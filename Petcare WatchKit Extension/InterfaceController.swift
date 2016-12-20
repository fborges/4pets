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
        

        
        if let testDefaults = defaults.array(forKey: "Pet") as? [[String:String]] {
            
            test = testDefaults
            loadTableData()
            
        }
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateRoutine routine: [String : Any]) {
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictAux = dictionary["Bath"] as! NSDictionary
        
        let petName = dictAux["petName"] as! String
        
        deletePetRoutineList(type: "Bath", petName: petName)
        deletePetRoutineList(type: "Hair", petName: petName)
        deletePetRoutineList(type: "Recreation", petName: petName)
        deletePetRoutineList(type: "Feeding", petName: petName)
        
        saveBathToDefaults(routine: routine)
        saveRecreationToDefaults(routine: routine)
        saveHairToDefaults(routine: routine)
        saveFoodToDefaults(routine: routine)


    }
    
    func deletePetRoutineList(type: String, petName: String){
        
        let defaults = UserDefaults()
        if let testDefaults = defaults.array(forKey: type) as? [[String:String]] {
            
            var position = 0
            
            var arrayToRemove = testDefaults
            for recreations in arrayToRemove {
                
                if recreations["Pet"] == petName {
                    
                    arrayToRemove.remove(at: position)
                    defaults.set(arrayToRemove, forKey: type)

                }
                
                position += 0
            }
            arrayToRemove = (defaults.array(forKey: type) as? [[String:String]])!
            
            print(arrayToRemove)
            
            
        }
    }
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, deletePet pet: [String : Any]) {
        
        if let testDefaults = defaults.array(forKey: "Pet") as? [[String:String]] {
            var position = 0
            self.test = testDefaults

            for pets in testDefaults {
                let comparator = pet["Created"] as? NSDictionary
            
                if pets["Name"] == comparator?["Name"] as? String{
                    self.test.remove(at: position)
                    defaults.set(self.test, forKey: "Pet")
                    deleteRotines(petName: comparator?["Name"] as! String)
                }
                
                position += 1
            }
            self.test = (defaults.array(forKey: "Pet") as? [[String:String]])!
        }
        
        
        loadTableData()
    }
    
    func deleteRotines(petName: String){
        var position = 0

        if let testDefaults = defaults.array(forKey: "Bath") as? [[String:String]] {
            for pets in testDefaults {
                if pets["Pet"] == petName {
                    self.test = testDefaults
                    self.test.remove(at: position)
                    defaults.set(self.test, forKey: "Bath")
                }
                
                position += 1
            }
            position = 0
            self.test = (defaults.array(forKey: "Bath") as? [[String:String]])!
            
        }
        
        if let testDefaults = defaults.array(forKey: "Hair") as? [[String:String]] {
            
            for pets in testDefaults {
                if pets["Pet"] == petName {
                    self.test = testDefaults
                    self.test.remove(at: position)
                    defaults.set(self.test, forKey: "Hair")
                }
                
                position += 1
            }
            position = 0
            
        }
        
        if let testDefaults = defaults.array(forKey: "Recreation") as? [[String:String]] {
            
            for pets in testDefaults {
                if pets["Pet"] == petName {
                    self.test = testDefaults
                    self.test.remove(at: position)
                    defaults.set(self.test, forKey: "Recreation")
                }
                
                position += 1
            }
            position = 0
        }
        
        if let testDefaults = defaults.array(forKey: "Feeding") as? [[String:String]] {
            
            for pets in testDefaults {
                if pets["Pet"] == petName {
                    self.test = testDefaults
                    self.test.remove(at: position)
                    defaults.set(self.test, forKey: "Feeding")
                }
                
                position += 1
            }
            position = 0
            
        }
        
    }
    
  
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithPetList petList: [String : Any]) {
        
        let dict = petList["Created"] as! NSDictionary
        
        
        if let testDefaults = defaults.array(forKey: "Pet") as? [[String:String]] {
            
            //let pet = PetWatch(name: testDefaults[0])
            
            self.test = testDefaults
            self.test.insert(dict as! [String:String], at: 0)
            defaults.set(self.test, forKey: "Pet")
            
            
        } else {
            let dict = petList["Created"] as! NSDictionary
            defaults.set([dict], forKey: "Pet")
            self.test = (defaults.array(forKey: "Pet") as? [[String:String]])!
        }
        
        loadTableData()
        
    }
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithRoutine routine: [String : Any]) {
        
        saveBathToDefaults(routine: routine)
        saveRecreationToDefaults(routine: routine)
        saveHairToDefaults(routine: routine)
        saveFoodToDefaults(routine: routine)
        
    }
    
    func saveBathToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictBath = dictionary["Bath"] as! NSDictionary
        
        let bath = ["Type":"Bath", "time":dictBath["time"] as? String,"frequency":dictBath["frequency"] as? String,
                    "Pet":dictBath["petName"] as? String]
        if let testDefaults = defaults.array(forKey: "Bath") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(bath as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "Bath")
            
        } else {
            
            defaults.set([bath], forKey: "Bath")
        }
        

    }
    
    func saveRecreationToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictRecreation = dictionary["Recreation"] as! NSDictionary
        
        let recreation = ["Type":"Recreation", "time":dictRecreation["time"] as? String,"frequency":dictRecreation["frequency"] as? String, "Pet":dictRecreation["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "Recreation") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(recreation as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "Recreation")
            
        } else {
            
            defaults.set([recreation], forKey: "Recreation")
        }

    }
    
    func saveHairToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictHair = dictionary["Hair"] as! NSDictionary
        
        let hair = ["Type":"Hair", "time":dictHair["time"] as? String,"frequency":dictHair["frequency"] as? String,
                    "Pet":dictHair["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "Hair") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(hair as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "Hair")
            
        } else {
            
            defaults.set([hair], forKey: "Hair")
        }

    }
    
    func saveFoodToDefaults(routine: [String : Any]){
        
        let dictionary = routine["Created"] as! NSDictionary
        
        let dictFood = dictionary["Feeding"] as! NSDictionary
        
        let food = ["Type":"Feeding", "time":dictFood["time"] as? String,"frequency":dictFood["frequency"] as? String,
                    "Pet":dictFood["petName"] as? String]
        
        if let testDefaults = defaults.array(forKey: "Feeding") as? [[String:String]] {
            
            var arrayToInsert = testDefaults
            arrayToInsert.insert(food as! [String:String], at: 0)
            defaults.set(arrayToInsert, forKey: "Feeding")
            
        } else {
            
            defaults.set([food], forKey: "Feeding")
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

}
