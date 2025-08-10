//
//  TattooStyle.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import Foundation

struct TattooStyle: Identifiable, Hashable, Equatable{
    let id: UUID = UUID()
    let tattooStyleIcon: String
    let tattooStyleName: String
    let tattooDescription: String
}
