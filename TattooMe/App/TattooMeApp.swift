//
//  TattooMeApp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 27/06/2025.
//

import SwiftUI
import SwiftData
import RevenueCat

@main
struct TattooMeApp: App {
    
#if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
   
    let persistenceController = PersistenceController.shared

    init() {
        Purchases.configure(withAPIKey: "appl_gQVlzYbUpubdEfwftdMEJHLzrxs")
        
        //customize tabview
        customizeTabView()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                
        }
    }
    
    func customizeTabView(){
        let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor.systemBackground

                tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.orange
                tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.orange]

                tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
                tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

                UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}

