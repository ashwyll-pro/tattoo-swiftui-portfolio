//
//  LimitedOfferView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import SwiftUI

struct LimitedOfferView: View {
    var onSubscribe: () -> Void
    var subscriptionPackage: SubscriptionPackage?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var premiumSubscriptionModel = PremiumSubscriptionViewModel()
    @State var offerPercentage: String?
    @State var alertType: AlertType?
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }

            GeometryReader { geometry in
                VStack(spacing: AppSpacing.medium) {
                    
                    // Close button
                    HStack {
                        Spacer()
                        Button(action:{
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.gray)
                        }
                    }

                    Text("limitedoffer.exclusive_deal").titleTextStyle()
                    
                    Text("50% OFF").titleTextStyle()
                
//                    if let  offerPercentage = self.offerPercentage{
//                        Text(String(format: NSLocalizedString("limitedoffer.claim_offer_with_percentage", comment: ""), offerPercentage) ).subTitleTextStyle()
//                    }else{
//                        Text("limitedoffer.claim_offer_now").subTitleTextStyle()
//                    }
                    

                    ForEach(premiumSubscriptionModel.packages){ package in
                        
                        Text(package.subtitle)
                            .foregroundStyle(.orange)
                            .subTitleTextStyle()

                        Text(String(format: NSLocalizedString("limitedoffer.billed_annually", comment: ""), package.packagePrice))
                            .bodyTextStyle()
                        
                    }

                    if let defaultAnnuallySub = subscriptionPackage?.packagePrice{
                        Text(defaultAnnuallySub)
                            .captionTextStyles()
                            .strikethrough()
                            .foregroundColor(.gray)
                    }

                    Button(action:{
                        if premiumSubscriptionModel.isLoading{
                            alertType = .loading
                            return
                        }
                        
                        if !premiumSubscriptionModel.error.isEmpty{
                            alertType = .failure(message: premiumSubscriptionModel.error)
                            return
                        }
                        Task{
                            await premiumSubscriptionModel.purchaseProduct(packageType: .annual)
                        }
                    }) {
                        if premiumSubscriptionModel.isLoading{
                            ProgressView()
                        }else{
                            Text("limitedoffer.unlock_offer")
                                .subTitleTextStyle()
                        }
                    }
                    .secondaryButtonStyle(width: geometry.size.width * 0.7)
                }
                .padding()
                .frame(width: geometry.size.width * 0.8)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.medium)
                        .fill(Colors.primary)
                        .overlay(Image("splash_one")
                            .resizable()
                            .cornerRadius(AppRadius.medium)
                            .opacity(0.2))
                        .shadow(radius: AppRadius.small)
                    
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
        }
        .transition(.opacity.combined(with: .scale))
        .animation(.easeInOut, value: UUID())
        
        .task {
            await premiumSubscriptionModel.getProducts(offering: "offer")
        }
        
        .onChange(of: premiumSubscriptionModel.error){ newError in
            if !newError.isEmpty {
                alertType = .failure(message: newError)
            }
        }
        
        .onChange(of: premiumSubscriptionModel.isPro){ subscribed in
            onSubscribe()
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
}

    #Preview {
        ZStack {
            Color.white
                .ignoresSafeArea()

            LimitedOfferView(onSubscribe: {
                    print("Claimed offer")
                }
            )
        }
    }

