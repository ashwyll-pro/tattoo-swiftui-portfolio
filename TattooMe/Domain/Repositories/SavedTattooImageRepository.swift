//
//  SavedTattooImageRepository.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation
protocol SavedTattooImageRepository{
    func getSavedImageTattoo()->[SavedTattooImage]
    func deleteSavedImageTattoo(fileUrl: URL) throws
}
