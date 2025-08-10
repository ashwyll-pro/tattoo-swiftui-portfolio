//
//  TattooGenerationViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 22/07/2025.
//

import Foundation

class TattooGenerationViewModel: ObservableObject{
    let generationLimitUseCase: GenerationLimitUseCase
    let tattooStyleUseCase: TattooStyleUseCase
    
    @Published var tattooDesignItems: [TattooStyle] = []
    
    init(generationLimitUseCase: GenerationLimitUseCase, tattooStyleUseCase: TattooStyleUseCase) {
        self.generationLimitUseCase = generationLimitUseCase
        self.tattooStyleUseCase = tattooStyleUseCase
    }
    
    func checkGenerationLimitHit() -> Bool{
        if let generationLimit = generationLimitUseCase.getGenerationLimit(){
           return  generationLimit.generationCount >= 30
        }
        
        return false
    }
    
    @MainActor
    func getTattooStyle() async throws{
        tattooDesignItems = try await tattooStyleUseCase.getTattooStyle()
    }
}
