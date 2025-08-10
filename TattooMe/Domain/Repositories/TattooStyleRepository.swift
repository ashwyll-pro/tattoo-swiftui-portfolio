//
//  TattooStyleRepository.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

protocol TattooStyleRepository{
    func getTattooStyle() async throws ->[TattooStyle]
}
