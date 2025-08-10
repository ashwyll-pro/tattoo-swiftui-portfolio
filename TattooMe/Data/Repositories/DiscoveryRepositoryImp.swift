//
//  DiscoveryRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

struct DiscoveryRepositoryImp: DiscoveryRepository{
   
    let myTattooDiscoveryRemoteSource: MyTattooDiscoveryRemoteSource
    
    init(myTattooDiscoveryRemoteSource: MyTattooDiscoveryRemoteSource) {
        self.myTattooDiscoveryRemoteSource = myTattooDiscoveryRemoteSource
    }
    
    func getTattooDiscover() async throws -> [Discover] {
        try await myTattooDiscoveryRemoteSource.getTattooDiscovery()
    }
    
    func getTattooDiscoverbyStyle(tattooStyleID: String) async throws -> [DiscoverItem] {
         try await myTattooDiscoveryRemoteSource.getTattooDiscoveryByTattooStyleID(tattooStyleID: tattooStyleID)
    } 
}
