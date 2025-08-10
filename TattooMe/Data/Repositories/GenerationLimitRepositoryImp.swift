//
//  GenerationLimitRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 22/07/2025.
//

import Foundation

struct GenerationLimitRepositoryImp: GenerationLimitRepository{
    func saveGenerationLimit(generationLimit: GenerationLimit) {
        if let encoded = try? JSONEncoder().encode(generationLimit) {
            UserDefaults.standard.set(encoded, forKey: "generationLimit")
        }
    }
    
    func getGenerationLimit() -> GenerationLimit? {
        if let savedData = UserDefaults.standard.data(forKey: "generationLimit"),
           let generationLimit = try? JSONDecoder().decode(GenerationLimit.self, from: savedData){
            return generationLimit
        }
        return nil
    }
}
