//
//  SavedTattooImageUseCase.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation
struct SavedTattooImageUseCase{
    let savedTattooImageRepository: SavedTattooImageRepository
    
    init(savedTattooImageRepository: SavedTattooImageRepository) {
        self.savedTattooImageRepository = savedTattooImageRepository
    }
    
    func getSavedTattooImageURL() -> [SavedTattooImage]{
        return savedTattooImageRepository.getSavedImageTattoo()
    }
    
    func deleteSavedTattooImage(fileUrl: URL) throws{
        try savedTattooImageRepository.deleteSavedImageTattoo(fileUrl: fileUrl)
    }
}
