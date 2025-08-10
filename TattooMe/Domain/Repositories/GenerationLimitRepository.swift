//
//  GenerationLimitRepository.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 22/07/2025.
//

protocol GenerationLimitRepository{
    func saveGenerationLimit(generationLimit: GenerationLimit)
    func getGenerationLimit()->GenerationLimit?
}
