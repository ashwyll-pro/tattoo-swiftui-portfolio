//
//  VisualEffectBlur.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 31/07/2025.
//

import SwiftUI

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: effect))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
