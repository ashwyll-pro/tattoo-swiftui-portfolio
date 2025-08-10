//
//  MockMyTattooDiscoverySource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

struct MockMyTattooDiscoverySource{
    func getTattooDiscovery() async throws -> [Discover]{
        return [
            
            Discover(tattooStyleID: "12", tattooStyle: "minimal", discoverItemsList: [
                DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
                DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
                DiscoverItem(tattooUrl: "ur3", tattooPrompt: "prompt three"),
                DiscoverItem(tattooUrl: "ur4", tattooPrompt: "prompt four"),
            ]),
            
            Discover(tattooStyleID: "12", tattooStyle: "japanese", discoverItemsList: [
                DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
                DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
            ]),
            
            Discover(tattooStyleID: "12", tattooStyle: "america", discoverItemsList: [
                DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
                DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
                DiscoverItem(tattooUrl: "ur3", tattooPrompt: "prompt three"),
                DiscoverItem(tattooUrl: "ur4", tattooPrompt: "prompt four"),
                DiscoverItem(tattooUrl: "ur5", tattooPrompt: "prompt five")
            ]),
            
            Discover(tattooStyleID: "12", tattooStyle: "ascent", discoverItemsList: [
                DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
                DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
                DiscoverItem(tattooUrl: "ur3", tattooPrompt: "prompt three"),
                DiscoverItem(tattooUrl: "ur4", tattooPrompt: "prompt four"),
                DiscoverItem(tattooUrl: "ur5", tattooPrompt: "prompt five")
            ]),
            
            Discover(tattooStyleID: "12", tattooStyle: "blackworth", discoverItemsList: [
                DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
                DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
                DiscoverItem(tattooUrl: "ur3", tattooPrompt: "prompt three"),
                DiscoverItem(tattooUrl: "ur4", tattooPrompt: "prompt four"),
                DiscoverItem(tattooUrl: "ur5", tattooPrompt: "prompt five")
            ])
        ]
    }
    
    
    func getTattooDiscoveryByTattooStyleID(tattooStyleID: String) async throws -> [DiscoverItem]{
        return [
            DiscoverItem(tattooUrl: "ur1", tattooPrompt: "prompt one"),
            DiscoverItem(tattooUrl: "ur2", tattooPrompt: "prompt two"),
            DiscoverItem(tattooUrl: "ur3", tattooPrompt: "prompt three"),
            DiscoverItem(tattooUrl: "ur4", tattooPrompt: "prompt four"),
            DiscoverItem(tattooUrl: "ur5", tattooPrompt: "prompt five")
        ]
    }
}
