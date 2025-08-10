//
//  GenerationLimitUseCase.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 22/07/2025.
//

struct GenerationLimitUseCase{
    let generationLimitRepository: GenerationLimitRepository
    
    init(generationLimitRepository: GenerationLimitRepository) {
        self.generationLimitRepository = generationLimitRepository
    }
    
    func saveGenerationLimit(generationLimit: GenerationLimit){
        generationLimitRepository.saveGenerationLimit(generationLimit: generationLimit)
    }
    
    func getGenerationLimit()->GenerationLimit?{
        return generationLimitRepository.getGenerationLimit()
    }
}
