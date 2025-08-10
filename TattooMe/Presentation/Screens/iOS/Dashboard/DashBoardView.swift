//
//  DashBoardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

#if os(iOS)
import SwiftUI
import GoogleMobileAds

struct DashBoardView: View{
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var dashboardViewModel: DashboardViewModel
    @StateObject var premiumSubscriptionViewModel = PremiumSubscriptionViewModel()
    
    @State var showLimitedOffer = false
    @State var subscriptionPackage: SubscriptionPackage?
    @State var showPro = false
    @State var selectedTattooStyle: TattooStyle?
    
    var body: some View{
        NavigationStack{
            ZStack{
                Colors.primary.ignoresSafeArea()
                sectionView
                    .padding()
            }
            
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Text(AppName.appName).titleTextStyle()
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if !premiumSubscriptionViewModel.isPro{
                        Button(action: {
                            showPro = true
                        }) {
                            Text("subscription.pro.button")
                        } .iconPrimaryStyle()
                    }
                }
            }
            
            .fullScreenCover(isPresented: $showPro){
                PremiumSubscriptionView(onClose: {package in
                    print("closed")
                    if package == nil{
                        return
                    }
                    self.subscriptionPackage = package
                    showLimitedOffer = true
                },
                                        proSubscribed: {
                    premiumSubscriptionViewModel.isPro = true
                }
                )
            }
            
            .fullScreenCover(item: $selectedTattooStyle){ item in
                TattooGenerationView(tattooStyle: item, tattooGenerationViewModel: DependencyContainer.shared.makeTattooGenerationModel(), processingTattooViewModel: DependencyContainer.shared.makeProcessingTattooModel(), tattooPrompt: .constant(""))
            }
            
            .task {
                await  premiumSubscriptionViewModel.checkSubscriptionStatus()
                do{
                    try await dashboardViewModel.getTattooStyle()
                }catch{
                    print("\(error.localizedDescription)")
                }
            }
            .onAppear(){
                if !premiumSubscriptionViewModel.isPro{
                    showPro = true
                }
            }
            
            .sheet(isPresented: $showLimitedOffer){
                LimitedOfferView(onSubscribe: {
                    premiumSubscriptionViewModel.isPro = true
                    
                }, subscriptionPackage: self.subscriptionPackage)
                .presentationBackground(.ultraThinMaterial)
            }
            
            .navigationBarBackButtonHidden(true)
        }
    }
    
    var sectionView: some View{
        
        ScrollView{
            LazyVGrid(columns: columns, spacing: AppSpacing.small){
                Section(header:
                            VStack{
                    
                    if !premiumSubscriptionViewModel.isPro{
                        GeometryReader{ geometry in
                            Rectangle()
                                .frame(width: geometry.size.width, height: AdsSize.bannersAdsContainerHeight)
                                .cornerRadius(AppRadius.medium)
                                .overlay(
                                    BannerAdView(adUnit: Ads.bannerAdHome, adSize: AdSizeBanner)
                                        .frame(width: AdSizeBanner.size.width, height: AdsSize.bannersAdsHeight)
                                )
                        }
                        .frame(height: AdsSize.bannersAdsContainerHeight)
                    }
                    
                    VStack{
                        Text("dashboard.tattoo_styles.title").titleTextStyle()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("dashboard.select_style.label").captionTextStyles()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.padding(AppSpacing.small)
                }
                        
                ){
                    ForEach(dashboardViewModel.tattooDesignItems){ item in
                        TattoStyleCardView(item: item, selectedTattooStyle: item)
                            .onTapGesture {
                                selectedTattooStyle = item
                            }
                    }
                }
            }
        }
    }
}


#Preview {
    DashBoardView(dashboardViewModel: DependencyContainer.shared.makeDashboardViewModel())
}

#endif
