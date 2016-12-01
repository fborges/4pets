//
//  ConfirmPetViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class ConfirmPetViewController: UIViewController {

    @IBOutlet weak var bathTextField: UITextField!
    @IBOutlet weak var hairTextField: UITextField!
    @IBOutlet weak var nailsTextField: UITextField!
    @IBOutlet weak var vaccinationTextField: UITextField!
    @IBOutlet weak var teethTextField: UITextField!
    @IBOutlet weak var dewormingTextField: UITextField!
    @IBOutlet weak var recreationTextField: UITextField!
    
    let preferences = ["Nails", "Bath", "Vaccination", "Recreation", "Teeth", "Deworming", "Hair"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var pet: Pet!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
