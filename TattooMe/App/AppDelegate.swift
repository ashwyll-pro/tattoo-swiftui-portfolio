//
//  AppDelegate.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 07/07/2025.
//

#if os(iOS)

import UIKit
import GoogleMobileAds
//@available(macOS, unavailable)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        MobileAds.shared.start()
        return true
    }
}

#endif
