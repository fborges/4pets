//
//  Nails+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Nails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nails> {
        return NSFetchRequest<Nails>(entityName: "Nails");
    }


}
