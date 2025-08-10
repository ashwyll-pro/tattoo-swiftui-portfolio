//
//  SavedTattooImageDataSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation

struct SavedTattooImageDataSource{
    
    func getAllSavedTattooImages() -> [SavedTattooImage]{
        return ImageHelper.getAllImageURLsFromDocuments().map{ url in
            SavedTattooImage(imageUrl: url)
        }
    }
}
