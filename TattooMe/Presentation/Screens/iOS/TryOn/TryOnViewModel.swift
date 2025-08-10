//
//  TryOnViewModel.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation
class TryOnViewModel: ObservableObject{
    @Published var tryOnList:[String] = []
    let tryOnDataSource = TryOnDataSource()
    
    func getTryOnImages(){
        tryOnList = tryOnDataSource.tryOnDataSource()
    }
}
