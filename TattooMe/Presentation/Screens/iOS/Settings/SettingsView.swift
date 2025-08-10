//
//  SettingsView.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//
import SwiftUI
struct SettingsView: View{
    @Environment(\.openURL) var openURL
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View{
        ZStack{
            Color.black.ignoresSafeArea()
            
                List{
                    ForEach(settingsViewModel.settingsList){ setting in
                        SettingsCardView(iconName: setting.settingIcon, settingName: setting.settingName)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                
                                if setting.settingsUrl.isEmpty{
                                    //send share
                                    ShareApp.share(text: "Check out this app: \(AppURL.url)")
                                    return
                                }
                                if let url = URL(string: setting.settingsUrl){
                                    openURL(url)
                                }
                            }
                    }
                }
                .listStyle(.plain)
            
        }
        .onAppear(){
            settingsViewModel.getSettingsList()
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Text("Settings")
                    .titleTextStyle()
            }
        }
    }
}

#Preview {
    NavigationStack{
        SettingsView()
    }
}
