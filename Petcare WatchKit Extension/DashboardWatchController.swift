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
    
    
    @IBOutlet var petImage: WKInterfaceImage!
    
    @IBOutlet var petName: WKInterfaceLabel!
    
    @IBOutlet var petBreed: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let dict = context! as! NSDictionary
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
    
    @IBAction func gotToRoutine() {
    }
    
    
}
