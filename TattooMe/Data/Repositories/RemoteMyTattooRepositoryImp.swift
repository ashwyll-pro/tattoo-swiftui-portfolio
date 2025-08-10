//
//  RemoteMyTattooRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 08/07/2025.
//

import Foundation

struct RemoteMyTattooRepositoryImp: MyTattooRepository{
   
    
    var myTattooRemoteSource: MyTattooRemoteSource
   
    init(myTattooRemoteSource: MyTattooRemoteSource) {
        self.myTattooRemoteSource = myTattooRemoteSource
    }
    
    func addTattoo(tattoo: MyTattoo) throws {
    }
    
    func getAllMyTattoos() async throws -> [MyTattoo] {
        throw NSError(domain: "Not supported", code: 0, userInfo: [NSLocalizedDescriptionKey: "Not available in remote mode"])
    }
    
    func deleteMyTattoo(id: String) async throws {
    }
    
    func getTattooByPrompt(prompt: Prompt) async throws -> MyTattoo {
        let dto = try await myTattooRemoteSource.getMyTattooByPrompt(prompt: prompt)
        return dto.toDomain()
    }
}
