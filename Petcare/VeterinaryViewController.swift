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
    
    func create(appointment: Veterinary){
        
        dao.insert(appointment)
        
    }
    
    func delete(appointment: Veterinary){
        
        dao.delete(appointment)
    }
    
    func update(appointment: Veterinary){
        
        var appointmentToUpdate = getByID(id: appointment.objectID)
        
        appointmentToUpdate = appointment
        
        dao.update(appointmentToUpdate)
    }
    
    func getAll() -> [Veterinary] {
        
        return dao.getAll()
    }
    
    func getByID(id: NSManagedObjectID) -> Veterinary{
        
        return dao.getByID(id)
    }
    
}
