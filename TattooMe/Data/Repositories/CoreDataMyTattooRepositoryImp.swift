//
//  CoreDataMyTattooRepositoryImp.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import Foundation

struct CoreDataMyTattooRepositoryImp: MyTattooRepository{
   
    let coreDataTaskDataSource: CoreDataTaskDataSource
   
    init(coreDataTaskDataSource: CoreDataTaskDataSource) {
        self.coreDataTaskDataSource = coreDataTaskDataSource
    }
    
    func addTattoo(tattoo: MyTattoo) throws {
        try coreDataTaskDataSource.addTask(id: UUID(), name: tattoo.MyTattooName, url: tattoo.MyTattooUrl)
    }
    
    func getAllMyTattoos() async throws -> [MyTattoo] {
        let data = try coreDataTaskDataSource.fetchTask()
        return data.map{ data in
            MyTattoo(MyTattooName: data.myTattooName ?? "", MyTattooUrl: data.myTattooUrl ?? "")
        }
    }
    
    func deleteMyTattoo(id: String) async throws {
        
    }
    
    func getTattooByPrompt(prompt: Prompt) async throws -> MyTattoo {
        throw NSError(domain: "NotSupported", code: 0, userInfo: [NSLocalizedDescriptionKey: "Not available in local mode"])
    }
  
}
