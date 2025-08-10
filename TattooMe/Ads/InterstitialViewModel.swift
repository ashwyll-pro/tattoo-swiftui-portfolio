//
//  InterstitialViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 07/07/2025.
//

import GoogleMobileAds

class InterstitialViewModel: NSObject, ObservableObject, FullScreenContentDelegate {
    private var interstitialAd: InterstitialAd?
    @Published var adDismissed: Bool = false
    
    func loadAd() async {
        do {
          interstitialAd = try await InterstitialAd.load(
            with: Ads.interstitialAd, request: Request())
          interstitialAd?.fullScreenContentDelegate = self
            print("interstitial ad is loaded")
        } catch {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
        
      }
    
    func showAd()->Bool{
      guard let interstitialAd = interstitialAd else {
          print("Ad wasn't ready.")
        return false
      }
      interstitialAd.present(from: nil)
        return true
    }
    
    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
      print("\(#function) called")
    }

    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
      print("\(#function) called")
    }

    func ad(
      _ ad: FullScreenPresentingAd,
      didFailToPresentFullScreenContentWithError error: Error
    ) {
      print("\(#function) called")
    }

    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
      print("\(#function) called")
    }

    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
      print("\(#function) called")
    }

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
      print("\(#function) called")
      // Clear the interstitial ad.
      interstitialAd = nil
        adDismissed = true
    }
}

