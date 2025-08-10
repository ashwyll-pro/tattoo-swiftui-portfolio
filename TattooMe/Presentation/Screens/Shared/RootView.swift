//
//  RootView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 06/07/2025.
//

import SwiftUI

struct RootView: View{
#if os(iOS)
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    #endif
    
    @State private var showDashboard = false
    
    var body: some View{
#if os(iOS)
        Group{
            if showDashboard || hasCompletedOnboarding{
                HomeView()
            }else{
                SplashView(onComplete: {
                    hasCompletedOnboarding = true
                    showDashboard = true
                })
            }
        }
        #else
        let dashboardViewModel = DependencyContainer.shared.makeDashboardViewModel()
        MacDashboardView(dashboardViewModel: dashboardViewModel)
        #endif
    }
}
