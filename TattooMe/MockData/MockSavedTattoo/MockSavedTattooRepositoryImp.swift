//
//  MockSavedTattooRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 29/07/2025.
//

import Foundation

struct MockSavedTattooRepositoryImp: SavedTattooImageRepository{
    
    let mockSavedTattooDataSource: MockSavedTattooDataSource
    
    init(mockSavedTattooDataSource: MockSavedTattooDataSource) {
        self.mockSavedTattooDataSource = mockSavedTattooDataSource
    }
    
    func getSavedImageTattoo() -> [SavedTattooImage] {
        mockSavedTattooDataSource.getAllSavedTattooImages()
    }
    
    func deleteSavedImageTattoo(fileUrl: URL) throws {
    
    }
}
