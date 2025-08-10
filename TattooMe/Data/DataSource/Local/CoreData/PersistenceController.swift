//
//  PersistenceController.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 25/07/2025.
//

import CoreData
import Foundation
 class PersistenceController{
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
     
     private init() {
         container = NSPersistentContainer(name: "MyTattooModel")
         container.loadPersistentStores(completionHandler: { _, error in
             if let error = error{
                 fatalError("Unresolved error \(error)")
             }else{
                 print("successfully loaded core data")
             }
             
         })
     }
}
