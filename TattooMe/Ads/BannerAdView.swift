//
//  BannerAdView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 07/07/2025.
//

#if os(iOS)
import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize
    let adUnit: String
    
    init(adUnit: String, adSize: AdSize) {
        self.adUnit = adUnit
        self.adSize = adSize
    }
    
    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        banner.adUnitID = adUnit
        banner.load(Request())
        banner.delegate = context.coordinator
        return banner
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
}

class BannerCoordinator: NSObject, BannerViewDelegate {

  let parent: BannerAdView

  init(_ parent: BannerAdView) {
    self.parent = parent
  }

  func bannerViewDidReceiveAd(_ bannerView: BannerView) {
    print("DID RECEIVE AD.")
  }

  func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
    print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
  }
}

#Preview{
    BannerAdView(adUnit: Ads.bannerAdHome, adSize: AdSizeBanner)
        .frame(width: AdSizeBanner.size.width, height: AdsSize.bannersAdsHeight)
}

#endif
