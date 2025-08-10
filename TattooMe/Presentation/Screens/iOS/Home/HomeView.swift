//
//  HomeView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import SwiftUI
struct HomeView: View{
    @State var selectedTab = 0
    @State var tattooPrompt = ""
    
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                TabView(selection: $selectedTab){
                    
                    TattooGenerationView(tattooGenerationViewModel: DependencyContainer.shared.makeTattooGenerationModel(), processingTattooViewModel: DependencyContainer.shared.makeProcessingTattooModel(), tattooPrompt: $tattooPrompt)
                        .tabItem{
                            Image(systemName: "moon.stars.fill")
                            Text("home.create")
                        }.tag(0)
                    
                    DiscoverView(discoverViewModel: DependencyContainer.shared.makeDiscoveryModel(), selectedTab: $selectedTab, tattooPrompt: $tattooPrompt)
                    
                        .tabItem{
                            Image(systemName: "safari.fill")
                            Text("home.discover")
                        }.tag(1)
                    
                    NavigationStack{
                        MyTattoosView(myTattoosViewModel: DependencyContainer.shared.makeMyTattoosViewModel())
                    }
                    .tabItem{
                        Image(systemName: "clock")
                        Text("home.mytattoo")
                    }.tag(2)
                    
                    NavigationStack{
                        SettingsView()
                    }
                    .tabItem{
                        Image(systemName: "gearshape.2.fill")
                        Text("home.settings")
                    }.tag(3)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
