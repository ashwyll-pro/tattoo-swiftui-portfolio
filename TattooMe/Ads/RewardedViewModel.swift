//
//  RewardedViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 31/07/2025.
//

import GoogleMobileAds

class RewardedViewModel: NSObject, ObservableObject, FullScreenContentDelegate {
  @Published var coins = 0
  private var rewardedAd: RewardedAd?

  func loadAd() async {
    do {
      rewardedAd = try await RewardedAd.load(
        with: Ads.rewarderAd, request: Request())
      rewardedAd?.fullScreenContentDelegate = self
    } catch {
      print("Failed to load rewarded ad with error: \(error.localizedDescription)")
    }
  }
    
    func showAd(onReward: @escaping (Bool)->Void) {
    guard let rewardedAd = rewardedAd else {
        onReward(false)
      return print("Ad wasn't ready.")
    }

    rewardedAd.present(from: nil) {
      let reward = rewardedAd.adReward
      print("Reward amount: \(reward.amount)")
        onReward(true)
      self.addCoins(reward.amount.intValue)
    }
  }
    
  func addCoins(_ amount: Int) {
    coins += amount
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
    rewardedAd = nil
  }
}
