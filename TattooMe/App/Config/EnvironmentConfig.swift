//
//  Untitled.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 10/07/2025.
//

import Foundation

struct EnvironmentConfig{
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
}
