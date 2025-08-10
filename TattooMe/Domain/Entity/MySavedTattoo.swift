//
//  MySavedTattoo.swift
//  TattooMe
//
//  Created by daniel nyamasyo on 26/07/2025.
//

import CoreData

@objc(MySavedTattoo)
public class MySavedTattoo: NSManagedObject {
    // Core Data dynamically provides storage and implementation
}

extension MySavedTattoo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MySavedTattoo> {
        return NSFetchRequest<MySavedTattoo>(entityName: "MySavedTattoo")
    }
    
    // These properties must exactly match your Core Data model attributes:
    @NSManaged public var id: UUID?
    @NSManaged public var myTattooName: String?
    @NSManaged public var myTattooUrl: String?
}
