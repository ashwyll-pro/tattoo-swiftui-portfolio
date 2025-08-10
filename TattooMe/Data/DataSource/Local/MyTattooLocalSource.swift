//
//  MyTattooLocalSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 04/07/2025.
//

import Foundation

struct MyTattooLocalSource{
    
    func getMyTattooFromCoreData() async throws -> [MyTattoo]{
        return  [MyTattoo(MyTattooName: "Tattoo one", MyTattooUrl: "tattoo two"),
                MyTattoo(MyTattooName: "Tattoo two", MyTattooUrl: "tattoo two"),
                MyTattoo(MyTattooName: "Tattoo three", MyTattooUrl: "tattoo two")
        ]
    }
}
