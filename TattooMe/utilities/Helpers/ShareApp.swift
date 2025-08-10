//
//  ShareApp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 09/07/2025.
//

import UIKit

class ShareApp{
        static func share(text: String) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootVC = windowScene.windows.first?.rootViewController else {
                return
            }

            let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            rootVC.present(vc, animated: true)
        }
    }
