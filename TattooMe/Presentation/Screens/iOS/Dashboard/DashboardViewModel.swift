//
//  DashboardViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import Foundation

class DashboardViewModel: ObservableObject{
    let tattooStyleUseCase: TattooStyleUseCase
    
    @Published var tattooDesignItems: [TattooStyle] = []

    init(tattooStyleUseCase: TattooStyleUseCase){
        self.tattooStyleUseCase = tattooStyleUseCase
    }
    
    @MainActor
    func getTattooStyle() async throws{
        tattooDesignItems = try await tattooStyleUseCase.getTattooStyle()
    }
    
}
