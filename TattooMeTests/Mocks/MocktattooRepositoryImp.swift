//
//  MocktattooRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 14/07/2025.
//

import Foundation


struct MocktattooRepositoryImp: MyTattooRepository{

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
        return MyTattoo(MyTattooName: "tattoo one", MyTattooUrl: "")
    }
}
