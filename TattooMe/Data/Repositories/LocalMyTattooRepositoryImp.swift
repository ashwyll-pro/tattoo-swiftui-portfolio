//
//  LocalTattooStyleDataSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 03/07/2025.
//

import Foundation

struct LocalMyTattooRepositoryImp: MyTattooRepository{

    var myTattooLocalSource: MyTattooLocalSource
    
    init(myTattooLocalSource: MyTattooLocalSource) {
        self.myTattooLocalSource = myTattooLocalSource
    }
    
    func addTattoo(tattoo: MyTattoo) throws {
        print(tattoo)
    }
    
    func getAllMyTattoos() async throws  -> [MyTattoo] {
        return try await myTattooLocalSource.getMyTattooFromCoreData()
    }
    
    func deleteMyTattoo(id: String) {
        
    }
    
    func getTattooByPrompt(prompt: Prompt) async throws -> MyTattoo {
          throw NSError(domain: "NotSupported", code: 0, userInfo: [NSLocalizedDescriptionKey: "Not available in local mode"])
    }  
}
