//
//  InterfaceController.swift
//  Petcare WatchKit Extension
//
//  Created by Felipe Borges on 25/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate, WatchConnectivityManagerWatchDelegate {

    var session: WCSession!
    
    @IBOutlet var tableList: WKInterfaceTable!
    
    let defaults = UserDefaults.standard
    
    var test: [[String:String]] = [[:]]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WatchConnectivityManager.sharedConnectivityManager.delegate = self

        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let testDefaults = defaults.array(forKey: "TestPet") as? [[String:String]] {
            
            test = testDefaults
            loadTableData()
            
        }
        
        var dict: [[String : String]] = [[:]]
        
        let bath = ["Type":"Bath", "time":"12:00","frequency":"daily"]
        dict.insert(bath, at: 0)
        
        if let testDefaults = defaults.array(forKey: "TestBath") as? [[String:String]] {
            
            //let pet = PetWatch(name: testDefaults[0])
            
            self.test = testDefaults
            defaults.set(self.test, forKey: "TestBath")
            print(self.test)
            
            
        } else {
            
            let teste = dict[0] as NSDictionary
            
            print(teste)
            defaults.set([teste], forKey: "TestBath")
        }
    
        let array = defaults.array(forKey: "TestBath") as? [[String:String]]
        
        print(array!)
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
  
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithPetList petList: [String : Any]) {
        
        
        let dict = petList["Created"] as! NSDictionary
        
        
        if let testDefaults = defaults.array(forKey: "TestPet") as? [[String:String]] {
            
            //let pet = PetWatch(name: testDefaults[0])
            
            self.test = testDefaults
            self.test.insert(dict as! [String:String], at: 0)
            defaults.set(self.test, forKey: "TestPet")
            print(self.test)
            
            
        } else {
            print(dict)
            let dict = petList["Created"] as! NSDictionary
            defaults.set([dict], forKey: "TestPet")
            self.test = (defaults.array(forKey: "TestPet") as? [[String:String]])!
        }
        
        loadTableData()
        
    }
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithRoutine routine: [String : Any]) {
        
        saveBathToDefaults(routine: routine)
        saveRecreationToDefaults(routine: routine)
        saveHairToDefaults(routine: routine)
        
    }
    
    func saveBathToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictBath = dictionary["Bath"] as! NSDictionary
        
        let bath = ["Type":"Bath", "time":dictBath["time"] as? String,"frequency":dictBath["frequency"] as? String,
                    "Pet":dictBath["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "TestBath") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(bath as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "TestBath")
            
        } else {
            
            let teste = bath as NSDictionary
            
            defaults.set([teste], forKey: "TestBath")
        }
    }
    
    func saveRecreationToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictRecreation = dictionary["Recreation"] as! NSDictionary
        
        let recreation = ["Type":"Bath", "time":dictRecreation["time"] as? String,"frequency":dictRecreation["frequency"] as? String, "Pet":dictRecreation["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "TestRecreation") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(recreation as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "TestRecreation")
            
        } else {
            
            let teste = recreation as NSDictionary
            
            defaults.set([teste], forKey: "TestRecreation")
        }
    }
    
    func saveHairToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictHair = dictionary["Hair"] as! NSDictionary
        
        let hair = ["Type":"Hair", "time":dictHair["time"] as? String,"frequency":dictHair["frequency"] as? String,
                    "Pet":dictHair["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "TestHair") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(hair as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "TestHair")
            
        } else {
            
            let teste = hair as NSDictionary
            
            defaults.set([teste], forKey: "TestHair")
        }
    }
    
    func loadTableData(){
        
        tableList.setNumberOfRows(test.count, withRowType: "petController")
        
        for (index, content) in test.enumerated(){
            
            let row = tableList.rowController(at: index) as! PetRowController
            
            row.petName.setText(content["Name"]!)
            
            
        }
        
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "dashboardPet", context: test[rowIndex])
    }
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    //    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
    //        petArray = (applicationContext["petList"] as? [Pet])!
    //        loadTableData()
    //    }

}
