//
//  MyTattoosViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import Foundation
class MyTattoosViewModel: ObservableObject{
    let savedTattooImageUseCase: SavedTattooImageUseCase
    @Published var savedTattooURL: [SavedTattooImage] = []
    
    init(savedTattooImageUseCase: SavedTattooImageUseCase){
        self.savedTattooImageUseCase = savedTattooImageUseCase
    }
    
    @MainActor
    func getAllSavedTattooURL() async throws{
        savedTattooURL = savedTattooImageUseCase.getSavedTattooImageURL()
    }
    
    func deleteSavedTattoo(fileUrl: URL) throws {
       try savedTattooImageUseCase.deleteSavedTattooImage(fileUrl: fileUrl)
    }
}
