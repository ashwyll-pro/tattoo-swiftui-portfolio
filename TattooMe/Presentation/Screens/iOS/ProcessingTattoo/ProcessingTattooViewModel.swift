//
//  ProcessingTattooViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/07/2025.
//

import Foundation

class ProcessingTattooViewModel: ObservableObject{
    var myTattooUseCase: MyTattooUseCase
    var generationLimitUseCase: GenerationLimitUseCase
    
    
    @Published var myTattoo: MyTattoo?
   // @Published var errorMessage: String = nil
    @Published var isLoading: Bool = false

    
    init(myTattooUseCase: MyTattooUseCase, generationLimitUseCase: GenerationLimitUseCase) {
        self.myTattooUseCase = myTattooUseCase
        self.generationLimitUseCase = generationLimitUseCase
    }
    
    @MainActor
    func getTattooByPrompt(prompt: Prompt) async throws{
        isLoading = true
        defer {isLoading = false}
        
        do{
            myTattoo = try await myTattooUseCase.getTattooByPrompt(prompt: prompt)
        }catch{
            //errorMessage = error.localizedDescription
            print("Error fetching tattoo: \(error)")
            throw error
        }
    }
    
    func updateGenerationLimit() {
        let today = Date()
        let calendar = Calendar.current

        guard var generationLimit = generationLimitUseCase.getGenerationLimit() else {
            generationLimitUseCase.saveGenerationLimit(generationLimit: GenerationLimit(todayDate: today, generationCount: 1))
            return
        }

        if !calendar.isDateInToday(generationLimit.todayDate) {
            generationLimit = GenerationLimit(todayDate: today, generationCount: 1)
        } else {
            generationLimit.generationCount += 1
        }

        generationLimitUseCase.saveGenerationLimit(generationLimit: generationLimit)
    }
    
    func requestAppReview() -> Bool {
        generationLimitUseCase.getGenerationLimit()?.generationCount == 2
    }
}
