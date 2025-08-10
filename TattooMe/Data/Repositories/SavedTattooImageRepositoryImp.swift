//
//  SavedTattooImageRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation
struct SavedTattooImageRepositoryImp: SavedTattooImageRepository{
    
    let savedTattooImageDataSource: SavedTattooImageDataSource
    
    init(savedTattooImageDataSource: SavedTattooImageDataSource) {
        self.savedTattooImageDataSource = savedTattooImageDataSource
    }
    
    func getSavedImageTattoo() -> [SavedTattooImage] {
        return savedTattooImageDataSource.getAllSavedTattooImages()
    }
    
    func deleteSavedImageTattoo(fileUrl: URL) throws {
        try ImageHelper.deleteURIFromDocuments(urlImage: fileUrl)
    }
}
