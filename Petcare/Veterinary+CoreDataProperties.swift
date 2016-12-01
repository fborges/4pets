//
//  Veterinary+CoreDataProperties.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Veterinary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Veterinary> {
        return NSFetchRequest<Veterinary>(entityName: "Veterinary");
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?

}
