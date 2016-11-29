//
//  Deworming+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Deworming {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deworming> {
        return NSFetchRequest<Deworming>(entityName: "Deworming");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var pet: Pet?

}
