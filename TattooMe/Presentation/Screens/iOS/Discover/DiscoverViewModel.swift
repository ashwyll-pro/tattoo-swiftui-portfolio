//
//  ExploreViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 28/07/2025.
//

import Foundation

class DiscoverViewModel: ObservableObject{
    let discoverUseCase: DiscoveryUseCase
    @Published var discoverList: [Discover] = []
    @Published var discoverItemList: [DiscoverItem] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    init(discoverUseCase: DiscoveryUseCase) {
        self.discoverUseCase = discoverUseCase
    }
    
    @MainActor
    func getTattoosDiscover() async{
        isLoading = true
        do{
            discoverList = try await discoverUseCase.getTattooDiscover()
        }catch{
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func getTattoosDiscoverByTattooStyleID(tattooStyleID: String) async{
        isLoading = true
        do{
            discoverItemList = try await discoverUseCase.getTattoosDiscoverByTattooStyleID(tattooStyleID: tattooStyleID)
        }catch{
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
