//
//  LocalTattooStyleRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 05/07/2025.
//

struct LocalTattooStyleRepositoryImp: TattooStyleRepository{
    let tattooStyleLocalSource: TattooStyleLocalSource
    
    func getTattooStyle() -> [TattooStyle] {
       return tattooStyleLocalSource.tattooStyleLocalSource()
    }
}
