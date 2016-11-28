//
//  CoreDataDAO.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    
    static var className: String {
        return String(describing: self)
    }
}

open class CoreDataDAO<Element: NSManagedObject>: DAO {
    
    fileprivate var context: NSManagedObjectContext
    
    public init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    open func insert(_ object: Element) {
        context.insert(object)
        save()
    }
    
    open func delete(_ object: Element) {
        context.delete(object)
        save()
    }
    
    public func getByID(_ id: NSManagedObjectID) -> Element {
        
        return context.object(with: id) as! Element
    }
    
    open func update(_ object: Element) {
        
        save()
        
    }
    
    open func getAll() -> [Element] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Object.className)
        let result =  try! context.fetch(request) as! [Object]
        return result
    }
    
    fileprivate func save() {
        try! context.save()
    }
    
    open func new() -> Element {
        return NSEntityDescription.insertNewObject(forEntityName: Element.className, into: context) as! Element
    }
}
