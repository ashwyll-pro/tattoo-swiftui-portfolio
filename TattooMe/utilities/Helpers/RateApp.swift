//
//  RateApp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 22/07/2025.
//

import UIKit
import StoreKit

class RateApp{
    static func requestAppReview() {
        if let windowScene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
