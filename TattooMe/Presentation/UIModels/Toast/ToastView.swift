//
//  ToastView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import SwiftUI
struct ToastView: View{
    let message: String
    let alignment: Alignment

    var body: some View {
        VStack{
            Text(message)
                .padding()
                .background(Color.red.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(AppRadius.medium)
                .padding(.horizontal, AppSpacing.medium)
                .transition(.move(edge: .top).combined(with: .opacity))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}
