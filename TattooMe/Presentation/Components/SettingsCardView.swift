//
//  SettingsCardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 30/07/2025.
//

import SwiftUI
struct SettingsCardView: View{
    var iconName: String
    var settingName: String
    var body: some View{
        HStack{
            Image(systemName: iconName)
                .backIconstyle()
               Text(settingName)
                .bodyTextStyle()
            Spacer()
            Image(systemName: "chevron.forward")
                .backIconstyle()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(AppRadius.medium)
    }
}

#Preview {
    ZStack{
        Color.black.ignoresSafeArea()
        SettingsCardView(iconName: "chevron.forward", settingName: "privacy policy")
    }
}
