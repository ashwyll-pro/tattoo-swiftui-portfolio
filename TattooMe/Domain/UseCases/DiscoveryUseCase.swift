//
//  DiscoveryUseCase.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

struct DiscoveryUseCase{
    let discoveryRepository: DiscoveryRepository
    
    init(discoveryRepository: DiscoveryRepository) {
        self.discoveryRepository = discoveryRepository
    }
    
    func getTattooDiscover() async throws -> [Discover] {
        try await discoveryRepository.getTattooDiscover()
    }
    
    func getTattoosDiscoverByTattooStyleID(tattooStyleID: String) async throws -> [DiscoverItem]{
        try await discoveryRepository.getTattooDiscoverbyStyle(tattooStyleID: tattooStyleID)
    }
}
