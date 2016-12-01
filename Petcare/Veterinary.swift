//
//  Veterinary+CoreDataClass.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData

@objc(Veterinary)
public class Veterinary: NSManagedObject {

    convenience init(name: String, phone: String, address: String, context: NSManagedObjectContext) {
        
        let entityName = "Veterinary"
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.phone = phone
        self.address = address
        
    }
    
}
