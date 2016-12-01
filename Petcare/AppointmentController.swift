//
//  AppointmentController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppointmentViewController: UIViewController {
    
    let dao = CoreDataDAO<Appointment>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func buildVeterinary(pet: Pet, veterinary: Veterinary) -> Appointment{
        
        let appointment = Appointment(price: NSDecimalNumber(), date: NSDate(), pet: pet, veterinary: veterinary, context: context)
        
        return appointment
    }
    
    func create(appointment: Appointment){
        
        dao.insert(appointment)
        
    }
    
    func delete(appointment: Appointment){
        
        dao.delete(appointment)
    }
    
    func update(appointment: Appointment){
        
        var appointmentToUpdate = getByID(id: appointment.objectID)
        
        appointmentToUpdate = appointment
        
        dao.update(appointmentToUpdate)
    }
    
    func getAll() -> [Appointment] {
        
        return dao.getAll()
    }
    
    func getByID(id: NSManagedObjectID) -> Appointment{
        
        return dao.getByID(id)
    }
    
}
