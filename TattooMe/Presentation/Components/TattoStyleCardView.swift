//
//  TattoStyleCard.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

#if os(iOS)
import SwiftUI

struct TattoStyleCardView: View{
    let item: TattooStyle
    let selectedTattooStyle: TattooStyle
    
    var body: some View{
        
        RoundedRectangle(cornerRadius: AppRadius.large)
            .fill(Color.gray)
            .overlay(
                ZStack {
                    Image(item.tattooStyleIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity, alignment: .top)
                        .clipped()
                    
                    Rectangle()
                        .fill(Gradients.clearToBlackLinear)
                    VStack{
                        Spacer()
                        Text(item.tattooStyleName)
                            .bodyTextStyle()
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(AppSpacing.small)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppRadius.large)
                    .stroke(selectedTattooStyle == item ? Color.orange : Color.gray, lineWidth: selectedTattooStyle == item ? 5 : 2)
                    .overlay(
                        selectedTattooStyle == item ?
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.orange)
                            .imageScale(.large)
                        
                        : nil)
                    
            )
            .frame(width: 120, height: 120)
            .cornerRadius(AppRadius.large)
            .padding()
    }
}


#Preview {
    ZStack{
        Colors.primary.ignoresSafeArea()
        let tattooStyle = TattooStyle(tattooStyleIcon: "trash_polka", tattooStyleName: "fresh", tattooDescription: "")
        TattoStyleCardView(item: tattooStyle, selectedTattooStyle: tattooStyle)
    }
}

#endif
