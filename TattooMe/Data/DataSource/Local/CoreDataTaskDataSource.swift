//
//  CoreDataTaskDataSource.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 25/07/2025.
//

import CoreData

final class CoreDataTaskDataSource{
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func addTask(id: UUID = UUID(), name: String, url: String) throws {
           let newTattoo = MySavedTattoo(context: context)
           newTattoo.id = id
           newTattoo.myTattooName = name
           newTattoo.myTattooUrl = url
           
           try context.save()
       }
    
    func fetchTask()throws -> [MySavedTattoo]{
        let request: NSFetchRequest<MySavedTattoo> = MySavedTattoo.fetchRequest()
        return try context.fetch(request)
    }
}
