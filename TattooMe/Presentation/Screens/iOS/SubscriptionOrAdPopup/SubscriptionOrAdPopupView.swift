//
//  SubscriptionOrAdPopupView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 30/07/2025.
//

import SwiftUI
struct SubscriptionOrAdPopupView: View{
    var watchAdClosure: ()->Void?
    var removeLimitClosure: ()->Void?
    var dismissView: () -> Void?
    var body: some View{
        ZStack{
            VisualEffectBlur(effect: .systemThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissView()
                }
            
            GeometryReader{ geometry in
                VStack(spacing: AppSpacing.medium){
                    
                    Image("tattoothree")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .cornerRadius(AppRadius.small)
                        .clipped()
                    
                    Text("subscription_or_adpopup.title")
                        .subTitleTextStyle()
                        .foregroundColor(.black)
                    Text("subscription_or_adpopup.subtitle")
                        .bodyTextStyle()
                    
                    Button(action: {
                        removeLimitClosure()
                    }){
                       Text("subscription_or_adpopup.remove_limits")
                    }  .primaryButtonStyle()
                    
                    Button(action: {
                        watchAdClosure()
                    }){
                        HStack(spacing: AppSpacing.medium){
                            Text("subscription_or_adpopup.watch_an_ad")
                                .font(.system(size: TextSize.medium, weight: .bold))
                            Image(systemName: "play.rectangle.on.rectangle.fill")
                        }
                    }
                    .tertiaryButtonStyle(width: geometry.size.width)
                    .padding(.vertical)
                    
                }
                .padding()
                .frame(width: geometry.size.width * 0.8)
                .background(
                    RoundedRectangle(cornerRadius: AppRadius.medium)
                        .fill(Color.black)
                        .overlay(
                                   RoundedRectangle(cornerRadius: AppRadius.medium)
                                    .stroke(Color.white.opacity(1.0), lineWidth: 1)
                               )
                    .shadow(radius: AppRadius.small)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .transition(.opacity.combined(with: .scale))
                .animation(.easeInOut, value: UUID())
            }
        }
    }
}

#Preview {
    SubscriptionOrAdPopupView(watchAdClosure: {}, removeLimitClosure: {}, dismissView: {})
}
