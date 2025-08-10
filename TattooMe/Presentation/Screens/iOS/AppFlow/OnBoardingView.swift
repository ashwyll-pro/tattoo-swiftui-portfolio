//
//  OnBoardingView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 27/06/2025.
//

import SwiftUI
struct OnBoardingView:View{
    let item: OnBoardingItem
    var body: some View{
        ZStack{
            
           scrollImage
            overlayView
            GeometryReader{ geometry in
                VStack(spacing: AppSpacing.small){
                    Text(item.title)
                        .titleTextStyle()
                    
                    Text(item.description)
                        .bodyTextStyle()
                        .opacity(0.5)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height - AppSpacing.xxxLarge, alignment: .bottom)
            }
        }
        
        .background(.black)
    }
    
    var scrollImage: some View {
        Image(item.image)
            .resizable()
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(AppRadius.medium)
        
    }
    
    var overlayView: some View{
        Rectangle()
            .fill(Gradients.clearToBlackLinear)
    }
}

#Preview {
    OnBoardingView(item: OnBoardingItem(title: "item", description: "description", image: "splash_one"))
}
