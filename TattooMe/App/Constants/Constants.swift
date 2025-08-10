//
//  AppStyleConstants.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/06/2025.
//

import SwiftUI

//padding and margin
enum AppSpacing{
    static let xSmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let xLarge: CGFloat = 32
    static let xxLarge: CGFloat = 40
    static let xxxLarge: CGFloat = 48
}


//modifier radius
enum AppRadius{
    static let xsmall: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let xLarge: CGFloat = 32
}

//text size
enum TextSize{
    static let small: CGFloat = 12
    static let medium: CGFloat = 18
    static let large: CGFloat = 24
    static let xLarge: CGFloat = 28
}

enum AppName{
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    ?? Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "TooMe"
}

enum Ads {
    static var interstitialAd: String {
        #if DEBUG
        return TestAds.interstitialAd
        #else
        return RealAds.interstitialAd
        #endif
    }

    static var bannerAdHome: String {
        #if DEBUG
        return TestAds.bannerAdHome
        #else
        return RealAds.bannerAdHome
        #endif
    }

    static var bannerAdGenerate: String {
        #if DEBUG
        return TestAds.bannerAdGenerate
        #else
        return RealAds.bannerAdGenerate
        #endif
    }
    
    static var rewarderAd: String {
        #if DEBUG
        return TestAds.rewardedAd
        #else
        return RealAds.rewardedAd
        #endif
    }
}

private enum TestAds{
    static let interstitialAd = "ca-app-pub-3940256099942544/4411468910"
    static let bannerAdHome = "ca-app-pub-3940256099942544/2435281174"
    static let bannerAdGenerate = "ca-app-pub-3940256099942544/2435281174"
    static let rewardedAd = "ca-app-pub-3940256099942544/1712485313"
}

private enum RealAds{
    static let interstitialAd = "interstitial ad id"
    static let bannerAdHome = "banner ad id"
    static let bannerAdGenerate = "banner ad generate id"
    static let rewardedAd = "rewarded ad id"
}

enum AdsSize{
    static let bannersAdsHeight: CGFloat = 250.0
    static let bannersAdsContainerHeight: CGFloat = 300
}

enum BaseUrl{
    static func getBaseUrl(release: Bool = true, param: String = "")->String{
        if release{
            return "\(EnvironmentConfig.baseURL)/api2/\(param)"
        }else{
            return "http://localhost:3001/api2/\(param)"
        }
    }
    
    static let  rootUrl = "root url"
}

enum AppURL{
    static let url = "app url"
}
