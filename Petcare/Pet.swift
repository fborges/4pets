//
//  Pet+CoreDataClass.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData

@objc(Pet)
public class Pet: NSManagedObject {

    convenience init(name: String, birthdate: NSDate?, breed: String, photo: NSData?, sex: String, type: String, context: NSManagedObjectContext) {
        
        let entityName = "Pet"
        
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.birthdate = birthdate
        self.breed = breed
        self.photo = photo
        self.sex   = sex
        self.type = type
        
    }
}
