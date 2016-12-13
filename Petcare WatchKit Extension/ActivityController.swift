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
    
    var petName: String!
    
    @IBOutlet var activityImage: WKInterfaceImage!
    
    @IBOutlet var activityLabel: WKInterfaceLabel!
    
    @IBOutlet var countdownTimer: WKInterfaceTimer!
    
    @IBOutlet var activityDateLabel: WKInterfaceLabel!
    
    @IBOutlet var frequencyLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let dict = context! as? NSDictionary
        self.activityLabel.setText(dict?["Type"] as? String)
        self.frequencyLabel.setText((dict?["frequency"] as? String))
        
        self.type = dict!["Type"] as? String
        
        let data  = (dict!["time"] as? String!)!
        
        self.petName = (dict!["Pet"] as? String!)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        self.activityDate = dateFormatter.date(from: data!)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        let activityDatePartOne = dateFormatter.string(from: activityDate!)
        self.dateCountdown = dateFormatter.date(from: activityDatePartOne)
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        
        self.activityDateLabel.setText(dateFormatter.string(from: activityDate!))
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        //INSERIR A DATA A PARTIR DA DATA PASSADA PELA ATIVIDADE EM QUESTÃO
        self.countdownTimer.setDate(dateCountdown)
        self.countdownTimer.start()
        
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
        activityDate = newDate!
        print(activityDate)
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        
        self.activityDateLabel.setText(dateFormatter.string(from: activityDate!))
        
        
        
        let defaults = UserDefaults()
        if let testDefaults = defaults.array(forKey: self.type!) as? [[String:String]] {
            
            var position = 0
            
            var arrayToInsert = testDefaults
            print(arrayToInsert)
            
            for recreations in arrayToInsert {
                
                if recreations["Pet"] == self.petName {
                    
                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                    
                    let recreation = ["Type":"Recreation", "time":dateFormatter.string(from: newDate!),"frequency":recreations["frequency"]!,
                                      "Pet":self.petName]
                    print(recreation)
                    
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
            
            try defaultSession.updateApplicationContext([
                "routineType":self.type
//                "designator": designator,
//                "designatorColor": designatorColor
                ])
        }
        catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    
    
}
