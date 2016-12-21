//
//  ActivityController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

class ActivityController: WKInterfaceController{
    
    var dateCountdown: Date!
    
    var type: String!
    
    var activityDate: Date!
    
    var activityDatePartOne: String!
    
    var petName: String!
    
    var frequency: String!
    
    @IBOutlet var activityImage: WKInterfaceImage!
    
    @IBOutlet var activityLabel: WKInterfaceLabel!
    
    @IBOutlet var countdownTimer: WKInterfaceTimer!
    
    @IBOutlet var activityDateLabel: WKInterfaceLabel!
    
    @IBOutlet var frequencyLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let dict = context! as? NSDictionary
        
        
        if (dict?["Type"] as? String == "Bath"){
            self.activityImage.setImageNamed("bath")
        } else if (dict?["Type"] as? String == "Recreation"){
            self.activityImage.setImageNamed("fun")
        } else if (dict?["Type"] as? String == "Hair"){
            self.activityImage.setImageNamed("hair")
        } else {
            self.activityImage.setImageNamed("food")
        }
        
        self.frequency = (dict?["frequency"] as? String)
        
        self.activityLabel.setText(dict?["Type"] as? String)
        self.frequencyLabel.setText((dict?["frequency"] as? String))
        
        self.type = dict!["Type"] as? String
        
        let data  = (dict!["time"] as? String!)!
        
        self.petName = (dict!["Pet"] as? String!)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        self.activityDate = dateFormatter.date(from: data!)

        dateFormatter.dateFormat = "h:mm a"
        self.activityDatePartOne = dateFormatter.string(from: activityDate!)
        
        self.dateCountdown = dateFormatter.date(from: activityDatePartOne)
        
        
        self.activityDateLabel.setText(dateFormatter.string(from: activityDate!))
        
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
    
    @IBAction func addHour() {
        
        let dateComponent = NSDateComponents()
        dateComponent.hour = 1
        
        let calendar = Calendar.autoupdatingCurrent
        let newDate = calendar.date(byAdding: dateComponent as DateComponents, to: activityDate)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "h:mm a"
        
        
        let pass12Hour: String = dateFormatter.string(from: newDate!)
        
        
        
        dateFormatter.dateFormat = "h:mm a"
        activityDate = dateFormatter.date(from: pass12Hour)
        
        self.activityDateLabel.setText(dateFormatter.string(from: activityDate!))
        
        let defaults = UserDefaults()
        if let testDefaults = defaults.array(forKey: self.type!) as? [[String:String]] {
            
            var position = 0
            
            var arrayToInsert = testDefaults
            
            for recreations in arrayToInsert {
                
                if recreations["Pet"] == self.petName {
                    
                    dateFormatter.dateFormat = "h:mm a"
                    
                    let recreation = ["Type":self.type, "time":dateFormatter.string(from: newDate!),"frequency":recreations["frequency"]!,
                                      "Pet":self.petName]
                    arrayToInsert.insert(recreation as! [String:String], at: position)
                    defaults.set(arrayToInsert, forKey: self.type!)
                    
                    
                }
                
                position += 0
            }
            
            
        }
        updateDesignatorApplicationContext()
        
        
    }
    
    func updateDesignatorApplicationContext() {
        let defaultSession = WCSession.default()
        
        do {
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "h:mm a"
            let type = self.type!
            let routine: [String:String] = ["name":type,"date":dateFormatter.string(from: self.activityDate),"frequency":self.frequency,"pet":self.petName]
            dateFormatter.dateFormat = "a"

            let amPM = dateFormatter.string(from: self.activityDate)
            
            try defaultSession.updateApplicationContext([
                "routineType":routine["name"]! as String,
                "Routine":routine,
                "amPM":amPM
                ])

        }
            
        catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
    }
    
    
}
