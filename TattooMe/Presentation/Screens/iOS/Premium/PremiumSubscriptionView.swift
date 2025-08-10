//
//  PremiumSubscription.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

#if os(iOS)
import SwiftUI
import RevenueCat
struct PremiumSubscriptionView: View{
    var onClose: (SubscriptionPackage?)->Void?
    var proSubscribed: ()->Void?
    
    @Environment(\.dismiss) var dismiss
    var proAccessList = [
        NSLocalizedString("pro_access.remove_daily_limit", comment: ""),
        NSLocalizedString("pro_access.no_ads", comment: ""),
        NSLocalizedString("pro_access.unlimited_tattoo_creation", comment: ""),
        NSLocalizedString("pro_access.fast_processing", comment: "")
    ]
    @State var packageType: PackageType = .annual
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    @State var alertType: AlertType?
    
    
    var body: some View{
        NavigationStack{
        ZStack{
            Colors.primary.ignoresSafeArea()
            ViewBody
        }
        
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    
                    let package = premiumSubscriptionViewModel.packages.first(where: {$0.packageType == .annual})
                    
                    onClose(package)
                    dismiss()
                    
                    //add a binded data
                    
                }){
                    Image(systemName: "xmark.circle")
                        .backIconstyle()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    Task{
                        await premiumSubscriptionViewModel.restorePurchase()
                    }
                }){
                    Text("premium.restore")
                        .iconPrimaryStyle()
                }
            }
        }
    }
        .navigationBarBackButtonHidden(true)
        .task{
            await premiumSubscriptionViewModel.getProducts(offering: "default")
        }
        
        .onChange(of: premiumSubscriptionViewModel.error) { newError in
                    if !newError.isEmpty {
                        alertType = .failure(message: newError)
                    }
                }
        
        .onChange(of: premiumSubscriptionViewModel.isPro){ isPro in
            proSubscribed()
            dismiss()
        }
        
        .alert(item: $alertType){ alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: .default(Text("ok.dismiss_button")) {
                    alertType = nil
                }
            )
        }
    }
    
    var ViewBody: some View{
        VStack{
            ZStack{
                Image("splash_one")
                    .resizable()
                    .scaledToFit()
                
                Rectangle()
                    .fill(Gradients.clearToBlackLinear)
                
                VStack{
                    Spacer()
                    
                    Text("premium.get_pro_access")
                        .titleTextStyle()
                        .bodyTextStyle()
                    
                    VStack(alignment: .leading){
                        ForEach(Array(proAccessList.enumerated()), id: \.offset) { _, item in
                            HStack (spacing: AppSpacing.medium) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Colors.buttonBackgroundPrimaryColor)
                                
                                Text(item)
                                    .captionTextStyles()
                                
                            }
                            .padding(.bottom, AppSpacing.xSmall)
                        }
                    }
                    .padding()
                }
            }
            
            VStack{
                if premiumSubscriptionViewModel.isLoading{
                    Rectangle()
                        .fill()
                        .overlay(
                            RoundedRectangle(cornerRadius: AppRadius.large)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .overlay(content: {
                            VStack{
                                Text("alert.loading.message").foregroundStyle(.white)
                                ProgressView()
                                    .tint(.white)
                            }
                        })
                        
                    
                }else{
   
                        ForEach( premiumSubscriptionViewModel.packages){ package in
                            PlanCardView(
                                isSelected: packageType == package.packageType, 
                                icon: "circle",
                                title: package.title,
                                subtitle: package.subtitle,
                                price: package.packagePrice,
                                duration: package.duration
                            ){
                                packageType = package.packageType
                            }

                        }
                    
                }
                
                Text("premium.auto_renewal.label")
                    .bodyTextStyle()
                    .padding(.top, AppSpacing.medium)
                
                GeometryReader{geometry in
                    VStack{
                        Button(action: {
                            
                            Task {
                                await premiumSubscriptionViewModel.purchaseProduct(packageType: self.packageType)
                                }
                        }){
                            Text(premiumSubscriptionViewModel.isLoading ?
                                 NSLocalizedString("button.loading", comment: "") :
                                 NSLocalizedString("button.continue", comment: ""))
                            
                        }.secondaryButtonStyle(width: geometry.size.width * 0.8)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }.frame(height: 80)
                
                HStack(alignment: .center){
                    Button(action: {
                        HttpLink.openHttpLink(link: "\(BaseUrl.rootUrl)terms-of-service")
                    }){
                        Text("terms_of_use.button")
                            .captionTextStyles()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        HttpLink.openHttpLink(link: "\(BaseUrl.rootUrl)privacy-policy")
                    }){
                        Text("privacy_policy.button")
                            .captionTextStyles()
                    }
                    
                }.padding()
            }
              
        }
    }
}

#Preview {
    NavigationView{
        PremiumSubscriptionView(onClose: {_ in }, proSubscribed: {})
    }
}

#endif
