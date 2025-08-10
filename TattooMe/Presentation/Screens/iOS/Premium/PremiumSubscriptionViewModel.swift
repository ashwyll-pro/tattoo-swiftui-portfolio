//
//  PremiumSubscriptionViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

import RevenueCat
import Foundation
import SwiftUI

@MainActor
final class PremiumSubscriptionViewModel: ObservableObject {
    @Published var packages: [SubscriptionPackage] = []
    @Published var isPro: Bool = false
    @Published var error: String = ""
    @Published var isLoading: Bool = true
    private var rcPackages: [Package] = []
    
    //fetch products
    func getProducts(offering identifier: String) async {
        await withCheckedContinuation { continuation in
            Purchases.shared.getOfferings { [weak self] offerings, error in
                guard let self = self else {
                    continuation.resume()
                    return
                }

                DispatchQueue.main.async {
                    self.isLoading = true
                }

                if let error = error {
                    DispatchQueue.main.async {
                        self.error = error.localizedDescription
                        self.isLoading = false
                    }
                    continuation.resume()
                    return
                }

                if let specificOffering = offerings?.all[identifier] {
                    DispatchQueue.main.async {
                        self.rcPackages = specificOffering.availablePackages
                        self.packages = self.rcPackages.map { package in
                            SubscriptionPackage(
                                isSelected: package.packageType == .annual, // default selection logic
                                packageType: package.packageType,
                                packagePrice: package.localizedPriceString,
                                rcPackage: package
                            )
                        }
                        self.isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.error = "Offering '\(identifier)' not found."
                        self.isLoading = false
                    }
                }

                continuation.resume()
            }
        }
    }
  
    //check subscription status
    func checkSubscriptionStatus() async {
        do {
            let info = try await Purchases.shared.customerInfo()
            isPro = info.entitlements["pro"]?.isActive == true
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    //initiate purchase
    func purchaseProduct(packageType: PackageType) async{
        do {
            guard let package = rcPackages.first(where: { $0.packageType == packageType }) else{
                self.error = "Package not found."
                return
            }
            
               let result = try await Purchases.shared.purchase(package: package)
               
               if result.customerInfo.entitlements["pro"]?.isActive == true {
                   isPro = true
               } else {
                   self.error = "Purchase not completed or entitlement not active."
               }
               
           } catch {
               self.error = error.localizedDescription
           }
    }
    
    //restore purchase
    func restorePurchase() async {
        do {
            let customerInfo = try await Purchases.shared.restorePurchases()
            
            if customerInfo.entitlements["pro"]?.isActive == true {
                isPro = true
            } else {
                self.error = "No active subscription found."
            }
        } catch {
            self.error = "Restore failed: \(error.localizedDescription)"
        }
    }
}

