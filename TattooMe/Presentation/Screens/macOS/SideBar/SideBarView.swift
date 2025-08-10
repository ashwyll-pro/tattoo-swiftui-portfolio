//
//  SideBarView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 14/07/2025.
//
import SwiftUI

struct SideBarView: View{
    @StateObject var dashboardViewModel: DashboardViewModel
    @State private var didLoad = false
    @Binding var selection: TattooStyle?
    
    var body: some View{
        List(selection: $selection){
            Section(header: Text("Tattoo Styles")){
                ForEach(dashboardViewModel.tattooDesignItems){ tattooStyle in
                    HStack(spacing: AppSpacing.medium){
                        MacTattooStyleCardView(tattooStyle: tattooStyle)
                    }
                    
                    .tag(tattooStyle)
                }
            }
    }
        .task {
            
            if didLoad{
                return
            }
            
            do{
                try await dashboardViewModel.getTattooStyle()
                didLoad = true
            }catch{
                print("Error loading tattoo styles: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    let dashboardViewModel = DependencyContainer.shared.makeDashboardViewModel()
    
    @State var selection: TattooStyle? = dashboardViewModel.tattooDesignItems.first

    
    SideBarView(dashboardViewModel: dashboardViewModel, selection: $selection)
        .listStyle(.sidebar)
}
