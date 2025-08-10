//
//  DiscoveryRepository.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

protocol DiscoveryRepository{
    func getTattooDiscover() async throws -> [Discover]
    func getTattooDiscoverbyStyle(tattooStyleID: String) async throws -> [DiscoverItem]
}
