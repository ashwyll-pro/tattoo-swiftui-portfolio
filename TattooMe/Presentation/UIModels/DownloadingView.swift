//
//  DownloadingView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 31/07/2025.
//

import SwiftUI
struct DownloadingView: View{
    let message: String

    var body: some View {
        VStack{
            Text(message)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(AppRadius.medium)
                .padding(.horizontal, AppSpacing.medium)
                .transition(.move(edge: .top).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}
