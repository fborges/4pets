//
//  VeterinaryViewController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VeterinaryViewController: UIViewController {
    
    let dao = CoreDataDAO<Veterinary>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func buildVeterinary() -> Veterinary{
        
        let veterinary = Veterinary(name: "", phone: "", address: "", context: context)
        
        return veterinary
    }
    
    func create(veterinary: Veterinary){
        
        dao.insert(veterinary)
        
    }
    
    func delete(veterinary: Veterinary){
        
        dao.delete(veterinary)
    }
    
    func update(veterinary: Veterinary){
        
        var veterinaryToUpdate = getByID(id: veterinary.objectID)
        
        veterinaryToUpdate = veterinary
        
        dao.update(veterinaryToUpdate)
    }
    
    func getAll() -> [Veterinary] {
        
        return dao.getAll()
    }
    
    func getByID(id: NSManagedObjectID) -> Veterinary{
        
        return dao.getByID(id)
    }
    
}
