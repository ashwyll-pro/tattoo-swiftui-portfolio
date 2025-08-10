//
//  AppSettings.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 21/07/2025.
//

import Foundation

struct AppSettings: Codable {
    var theme: String
    var notificationsEnabled: Bool
    var lastLoginDate: Date
}
