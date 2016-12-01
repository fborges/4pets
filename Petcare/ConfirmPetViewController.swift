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
        <#code#>
    }

    func add() {
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
        
    }
}
