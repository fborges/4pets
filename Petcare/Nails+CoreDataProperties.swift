//
//  Nails+CoreDataProperties.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Nails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nails> {
        return NSFetchRequest<Nails>(entityName: "Nails");
    }




}
