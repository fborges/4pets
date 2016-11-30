//
//  Hair+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Hair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hair> {
        return NSFetchRequest<Hair>(entityName: "Hair");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var pet: Pet?

}
