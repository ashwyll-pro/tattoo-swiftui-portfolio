//
//  TattooRequest.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 08/07/2025.
//

import Foundation

struct Prompt: Codable{
    var requestID: String
    var promptText: String
    var tattooStyle: String
    var tattooDescription: String
}
