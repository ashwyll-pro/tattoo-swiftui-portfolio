//
//  MacDashboardView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 10/07/2025.
//

#if os(macOS) || os(visionOS)

import SwiftUI
struct MacDashboardView: View{
    @StateObject var dashboardViewModel: DashboardViewModel
    @State private var selection: TattooStyle?
    var body: some View{
        
        NavigationSplitView(sidebar: {
            SideBarView(dashboardViewModel: dashboardViewModel, selection: $selection)
        }, detail: {
            let processTattooViewModel = DependencyContainer.shared.makeProcessingTattooModel()
            MacTattooGenerationView(tattooStyle: selection ?? TattooStyle(tattooStyleIcon: "Tribal", tattooStyleName: "Tribal"), processTattooViewModel: processTattooViewModel)
                .navigationTitle("Tattoo Designs app")
        })
        
    }
    
}

#Preview {
    let dashboardViewModel = DependencyContainer.shared.makeDashboardViewModel()
    MacDashboardView(dashboardViewModel: dashboardViewModel).frame(maxWidth: .infinity, maxHeight: .infinity)
}

#endif
