//
//  Teeth+CoreDataProperties.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CoreData


extension Teeth {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Teeth> {
        return NSFetchRequest<Teeth>(entityName: "Teeth");
    }




}
