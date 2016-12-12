//
//  Pet+CoreDataProperties.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet");
    }

    @NSManaged public var birthdate: NSDate?
    @NSManaged public var breed: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var sex: String?
    @NSManaged public var type: String?
    @NSManaged public var routine: NSOrderedSet?

}

// MARK: Generated accessors for routine
extension Pet {

    @objc(addRoutineObject:)
    @NSManaged public func addToRoutine(_ value: Routine)

    @objc(removeRoutineObject:)
    @NSManaged public func removeFromRoutine(_ value: Routine)

    @objc(addRoutine:)
    @NSManaged public func addToRoutine(_ values: NSOrderedSet)

    @objc(removeRoutine:)
    @NSManaged public func removeFromRoutine(_ values: NSOrderedSet)

}
