//
//  PetController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CoreData

class PetController: UIViewController {
    
    let dao = CoreDataDAO<Pet>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        
//        let pet = Pet(name: "Wesley", birthdate: NSDate(), breed: "Safadão", photo: NSData(), sex: "Masculino", type: "Raparigueiro", context: self.context)
//        self.create(pet: pet)
//        
//        let pets = getAll()
//        
//        print(pets[0].name!)
//        
//        let petToUpdate = getByID(id: pets[0].objectID)
//        
//        petToUpdate.name = "Senhor Wesley"
//        
//        let petAfterUpdate = getAll()
//        
//        print(petAfterUpdate[0].name!)
//        
//        
//        let petToDelete = getByID(id: petAfterUpdate[0].objectID)
//        print(petToDelete.name!)
//        self.delete(pet: petToDelete)
//        
//        let newPets = getAll()
//        print(newPets[0].name!)
        
        
    }
    
    func create(pet: Pet){
        
        dao.insert(pet)
    }
    
    func delete(pet: Pet){
        
        dao.delete(pet)
    }
    
    func update(pet: Pet){
        
        var petToUpdate = getByID(id: pet.objectID)
        
        petToUpdate = pet
        
        dao.update(petToUpdate)
    }
    
    func getAll() -> [Pet] {
        
        return dao.getAll()
    }
    
    func getByID(id: NSManagedObjectID) -> Pet{
        
        return dao.getByID(id)
    }
    
}
