//
//  Routine+CoreDataProperties.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine");
    }
    
    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var frequency: String?
    @NSManaged public var pet: Pet?

}
