//
//  ConfirmPetViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class ConfirmPetViewController: UIViewController {

    // outlets
    @IBOutlet weak var bathTextField: UITextField!
    @IBOutlet weak var hairTextField: UITextField!
    @IBOutlet weak var nailsTextField: UITextField!
    @IBOutlet weak var vaccinationTextField: UITextField!
    @IBOutlet weak var teethTextField: UITextField!
    @IBOutlet weak var dewormingTextField: UITextField!
    @IBOutlet weak var recreationTextField: UITextField!
    
    // local atributes
    let preferences = ["Nails", "Bath", "Vaccination", "Recreation", "Teeth", "Deworming", "Hair"]
    var pet: Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveOnDAO()
    }

    func saveOnDAO() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = bathTextField.text {
            let dao = CoreDataDAO<Bath>()
            let bath = dao.new()
            bath.date = dateFormatter.date(from: date) as NSDate?
            bath.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.bath as! NSMutableOrderedSet
            petBaths.add(bath)

            dao.insert(bath)

        }
        
        if let date = hairTextField.text {
            let dao = CoreDataDAO<Hair>()
            let hair = dao.new()
            hair.date = dateFormatter.date(from: date) as NSDate?
            hair.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.hair as! NSMutableOrderedSet
            petBaths.add(hair)
            
            dao.insert(hair)
            
        }
        
        if let date = teethTextField.text {
            let dao = CoreDataDAO<Teeth>()
            let teeth = dao.new()
            teeth.date = dateFormatter.date(from: date) as NSDate?
            teeth.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.teeth as! NSMutableOrderedSet
            petBaths.add(teeth)
            
            dao.insert(teeth)
            
        }
        
        if let date = recreationTextField.text {
            let dao = CoreDataDAO<Recreation>()
            let recreation = dao.new()
            recreation.date = dateFormatter.date(from: date) as NSDate?
            recreation.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.recreation as! NSMutableOrderedSet
            petBaths.add(recreation)
            
            dao.insert(recreation)
            
        }
        
        if let date = nailsTextField.text {
            let dao = CoreDataDAO<Nails>()
            let nails = dao.new()
            nails.date = dateFormatter.date(from: date) as NSDate?
            nails.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.nails as! NSMutableOrderedSet
            petBaths.add(nails)
            
            dao.insert(nails)
            
        }
        
        if let date = vaccinationTextField.text {
            let dao = CoreDataDAO<Vaccination>()
            let vaccination = dao.new()
            vaccination.date = dateFormatter.date(from: date) as NSDate?
            vaccination.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.vaccination as! NSMutableOrderedSet
            petBaths.add(vaccination)
            
            dao.insert(vaccination)
            
        }
        
        if let date = dewormingTextField.text {
            let dao = CoreDataDAO<Deworming>()
            let deworming = dao.new()
            deworming.date = dateFormatter.date(from: date) as NSDate?
            deworming.pet = self.pet
            
            // adding to pets array os baths
            let petBaths = pet?.deworming as! NSMutableOrderedSet
            petBaths.add(deworming)
            
            dao.insert(deworming)
            
        }
        
    }
}
