//
//  Pet+CoreDataProperties.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
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

}
