//
//  Bath+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Bath {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bath> {
        return NSFetchRequest<Bath>(entityName: "Bath");
    }

}
