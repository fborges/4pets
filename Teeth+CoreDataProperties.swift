//
//  Teeth+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Teeth {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teeth> {
        return NSFetchRequest<Teeth>(entityName: "Teeth");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var pet: Pet?

}
