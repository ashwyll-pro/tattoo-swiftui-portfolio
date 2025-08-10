//
//  TattooStyleUseCase.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

struct TattooStyleUseCase{
    let tattooStyleRepository: TattooStyleRepository
    
    func getTattooStyle() async throws -> [TattooStyle]{
       return try await tattooStyleRepository.getTattooStyle()
    }
}
