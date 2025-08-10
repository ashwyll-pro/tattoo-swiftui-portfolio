//
//  MyTattooRepository.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

protocol MyTattooRepository{
    func addTattoo(tattoo: MyTattoo) throws
    func getAllMyTattoos() async throws ->[MyTattoo]
    func deleteMyTattoo(id: String) async throws
    func getTattooByPrompt(prompt: Prompt) async throws -> MyTattoo
}
