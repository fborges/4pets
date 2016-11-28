//
//  DAO.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import CoreData


public protocol DAO {
    
    associatedtype Object
    
    func insert(_ object: Object)
    
    func delete(_ object: Object)
    
    func update(_ object: Object)
    
    func getByID(_ id: NSManagedObjectID) -> Object
    
    func getAll() -> [Object]
    
}
