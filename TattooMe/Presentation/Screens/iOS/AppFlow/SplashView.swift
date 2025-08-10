//
//  SplashView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 27/06/2025.
//

#if os(iOS)
import SwiftUI

struct SplashView: View {
    @State private var selectedTab: Int = 0
    @StateObject private  var viewModel = OnBoardingViewModel()
    
    @StateObject private var trackingManager = TrackingPermissionManager()
    
    var onComplete: ()->Void
    
    var body: some View {
        
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                TabView(selection: $selectedTab) {
                    ForEach(Array(viewModel.onBoardingViewItems.enumerated()), id: \.offset) { index, item in
                        OnBoardingView(item: item)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                
                Button(action: handleButtonTap){
                    Text(selectedTab == viewModel.onBoardingViewItems.count - 1 ? "Get Started": "Next")
                    
                }.primaryButtonStyle()
            }
        }
    } 
    
    private func handleButtonTap(){
        if selectedTab == viewModel.onBoardingViewItems.count - 1 {
            trackingManager.requestTrackingPermission()
            onComplete()

        }else{
            withAnimation{
                selectedTab += 1
            }
        }
    }
}


#Preview {
    SplashView(onComplete: {
        
    }).frame(maxWidth: .infinity, maxHeight: .infinity)
}

#endif
