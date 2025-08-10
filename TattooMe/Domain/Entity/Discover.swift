//
//  Discover.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import Foundation

struct Discover: Identifiable{
    var id = UUID()
    var tattooStyleID: String
    var tattooStyle: String
    var discoverItemsList: [DiscoverItem]
}

struct DiscoverItem: Hashable{
    var tattooUrl: String
    var tattooPrompt: String
}

extension DiscoverItem {
    init(from dto: TattooDTO) {
        self.tattooUrl = dto.tattooFileName
        self.tattooPrompt = dto.tattooPrompt
    }
}

extension Discover {
    init(from dto: DiscoverDTO) {
        self.tattooStyleID = UUID().uuidString
        self.tattooStyle = dto.tattooStyle
        self.discoverItemsList = dto.tattoos
            .map { DiscoverItem(from: $0) }
    }
}
