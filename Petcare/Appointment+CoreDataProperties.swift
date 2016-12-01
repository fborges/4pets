//
//  Appointment+CoreDataProperties.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Appointment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Appointment> {
        return NSFetchRequest<Appointment>(entityName: "Appointment");
    }

    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var date: NSDate?
    @NSManaged public var pet: Pet?
    @NSManaged public var veterinary: Veterinary?

}
