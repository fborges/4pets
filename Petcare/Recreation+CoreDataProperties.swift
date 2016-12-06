//
//  Recreation+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Recreation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recreation> {
        return NSFetchRequest<Recreation>(entityName: "Recreation");
    }


}
