//
//  Routine.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 06/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class Routine: NSManagedObject {
    
    @NSManaged public var date: NSDate?
    @NSManaged public var pet: Pet?

}
