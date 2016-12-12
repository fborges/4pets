//
//  DashboardWatchController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 08/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import WatchKit


class DashboardWatchController: WKInterfaceController {
    
    var pet: String!
    
    @IBOutlet var petImage: WKInterfaceImage!
    
    @IBOutlet var petName: WKInterfaceLabel!
    
    @IBOutlet var petBreed: WKInterfaceLabel!
    
    let defaults = UserDefaults.standard
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        let dict = context! as! NSDictionary
        self.pet = dict["Name"] as? String

        self.petName.setText(dict["Name"] as? String)
        self.petBreed.setText(dict["Breed"] as? String)
        if (dict["Type"] as? String == "Cat"){
            
            self.petImage.setImageNamed("cat")
        } else{
            self.petImage.setImageNamed("dog")
        }
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func bathButton() {
        
        if let testDefaults = defaults.array(forKey: "TestBath") as? [[String:String]] {
            
            
            for bath in testDefaults {
                
                if bath["Pet"] == self.pet {
                    
                     self.pushToRoutine(context: bath)
                    
                }
            }
            
        }
        
    }
    
    @IBAction func recreationButton() {
        
        if let testDefaults = defaults.array(forKey: "TestRecreation") as? [[String:String]] {
            
            
            for recreation in testDefaults {
                
                if recreation["Pet"] == self.pet {
                    
                    self.pushToRoutine(context: recreation)
                    
                }
            }
            
        }
        
    }
    
    @IBAction func hairButton() {
        
        if let testDefaults = defaults.array(forKey: "TestHair") as? [[String:String]] {
            
            
            for hair in testDefaults {
                
                if hair["Pet"] == self.pet {
                    
                    self.pushToRoutine(context: hair)
                    
                }
            }
            
        }
        
    }

    
    func pushToRoutine(context: Any){
        self.pushController(withName: "activity", context: context)
    }
    
}
