//
//  Vaccination+CoreDataProperties.swift
//  
//
//  Created by Raul Marques de Oliveira on 29/11/16.
//
//

import Foundation
import CoreData


extension Vaccination {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vaccination> {
        return NSFetchRequest<Vaccination>(entityName: "Vaccination");
    }


}
