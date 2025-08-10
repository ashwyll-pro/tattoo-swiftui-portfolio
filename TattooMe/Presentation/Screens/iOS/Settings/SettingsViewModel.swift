//
//  SettingsViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 30/07/2025.
//

import Foundation
class SettingsViewModel: ObservableObject{
    @Published var settingsList: [Settings] = []
    func getSettingsList(){
        settingsList = [
            Settings(settingIcon: "square.and.arrow.up", settingName: "Share with friends", settingsUrl: ""),
            Settings(settingIcon: "lock.shield", settingName: "Privacy Policy", settingsUrl: "\(BaseUrl.rootUrl)privacy-policy"),
            Settings(settingIcon: "text.document.fill", settingName: "Terms of Use", settingsUrl: "\(BaseUrl.rootUrl)terms-of-service")
         
        ]
    }
}
