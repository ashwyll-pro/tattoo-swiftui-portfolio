//
//  DiscoverDTO.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 30/07/2025.
//

struct DiscoverDTO: Decodable {
    let tattooStyle: String
    let tattoos: [TattooDTO]
}

struct TattooDTO: Decodable {
    let id: String
    let tattooStyle: String
    let tattooPrompt: String
    let tattooDescription: String
    let tattooFileName: String
    let tattooPublicDisplay: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tattooStyle
        case tattooPrompt
        case tattooDescription
        case tattooFileName
        case tattooPublicDisplay
    }
}

