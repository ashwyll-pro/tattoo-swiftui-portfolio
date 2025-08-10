//
//  MockDiscoveryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

struct MockDiscoveryImp: DiscoveryRepository{
    
    let mockMyTattooDiscoverySource: MockMyTattooDiscoverySource
    
    init(mockMyTattooDiscoverySource: MockMyTattooDiscoverySource) {
        self.mockMyTattooDiscoverySource = mockMyTattooDiscoverySource
    }
 
    func getTattooDiscover() async throws -> [Discover] {
        try await mockMyTattooDiscoverySource.getTattooDiscovery()
    }
    
    func getTattooDiscoverbyStyle(tattooStyleID: String) async throws -> [DiscoverItem] {
        try await mockMyTattooDiscoverySource.getTattooDiscoveryByTattooStyleID(tattooStyleID: tattooStyleID)
    }
}
