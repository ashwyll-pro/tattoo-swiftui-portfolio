//
//  MyTattoo.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

struct MyTattooUseCase{
    let myTattooRepository: MyTattooRepository

    func getAllMyTattoos() async throws ->[MyTattoo]{
        return try await myTattooRepository.getAllMyTattoos()
    }
    
    func deleteMyTattoo(id: String) async throws {
        return try await myTattooRepository.deleteMyTattoo(id: id)
    }
    
    func getTattooByPrompt(prompt: Prompt) async throws -> MyTattoo{
        return try await myTattooRepository.getTattooByPrompt(prompt: prompt)
    }
}
