//
//  PlanCardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import SwiftUI
struct PlanCardView: View {
    var isSelected: Bool
    var icon: String
    var title: String
    var subtitle: String
    var price: String
    var duration: String
    var onTap: ()->Void?

    var body: some View {
        Button(action: {
            onTap()
        }){
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : icon)
                    .foregroundColor(Colors.buttonBackgroundPrimaryColor)
                    .padding(.leading, AppSpacing.xSmall)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .subTitleTextStyle()
                    Text(subtitle)
                        .captionTextStyles()
                }
                
                
                Spacer()
                
                VStack {
                    Text(price)
                        .titleTextStyle()
                    Text(duration)
                        .captionTextStyles()
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .stroke(isSelected ? Colors.buttonBackgroundPrimaryColor : Color.gray, lineWidth: isSelected ? 2 : 1)
            )
            .padding(.horizontal, AppSpacing.small)
        }
    }
}
