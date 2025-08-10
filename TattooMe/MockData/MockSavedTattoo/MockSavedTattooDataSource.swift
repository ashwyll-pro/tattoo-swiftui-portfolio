//
//  SavedTattooImageDataSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 29/07/2025.
//

struct MockSavedTattooDataSource{
    func getAllSavedTattooImages() -> [SavedTattooImage]{
        guard let url = ImageHelper.convertImageToURL(named: "splash_two"), let url1 = ImageHelper.convertImageToURL(named: "splash_three") else { return [] }
        
        return [
            SavedTattooImage(imageUrl: url),
            SavedTattooImage(imageUrl: url1),
            SavedTattooImage(imageUrl: url),
            SavedTattooImage(imageUrl: url),
            SavedTattooImage(imageUrl: url),
            SavedTattooImage(imageUrl: url)
        ]
    }
}
