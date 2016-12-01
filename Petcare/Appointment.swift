//
//  Appointment+CoreDataClass.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData

@objc(Appointment)
public class Appointment: NSManagedObject {
    
    
    convenience init(price: NSDecimalNumber, date: NSDate, pet: Pet, veterinary: Veterinary, context: NSManagedObjectContext) {
        
        let entityName = "Veterinary"
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.price = price
        self.date = date
        self.pet = pet
        self.veterinary = veterinary
        
    }
    
}
