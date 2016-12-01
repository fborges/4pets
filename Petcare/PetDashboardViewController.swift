//
//  PetDashboardViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit


class PetDashboardViewController: UIViewController {

    // outlets
    @IBOutlet weak var petPhoto: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petBrithday: UILabel!
    @IBOutlet weak var petSex: UILabel!
    
    // internal variables
    var pet: Pet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // populatting outlets
        self.petPhoto.image = UIImage(data: pet.photo as! Data)
        self.petName.text = pet.name
        self.petBreed.text = pet.breed
        self.petBrithday.text = dateFormatter.string( from: pet.birthdate as! Date )
        self.petSex.text = pet.sex
        
    }
    
    @IBAction func selectRoutine(_ sender: Any) {
        
    }


    func configurePopUpMenu() {
        
    }
    



}
