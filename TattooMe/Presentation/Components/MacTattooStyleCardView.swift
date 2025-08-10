//
//  MacTattooStyleCardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 11/07/2025.
//

import SwiftUI
struct MacTattooStyleCardView: View{
    let tattooStyle: TattooStyle
    var body: some View{
        HStack(alignment: .center, spacing: AppSpacing.small) {
            Image(tattooStyle.tattooStyleIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .cornerRadius(AppRadius.small)
            
            
            Text(tattooStyle.tattooStyleName)
                 
               }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

