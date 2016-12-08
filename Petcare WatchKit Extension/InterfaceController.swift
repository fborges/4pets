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
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
  
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithPetList petList: [String : Any]) {
        
        
        let dict = petList["PetCreated"] as! NSDictionary
        
        if let testDefaults = defaults.array(forKey: "TestPet") as? [[String:String]] {
            
            //let pet = PetWatch(name: testDefaults[0])
            
            self.test = testDefaults
            self.test.insert(dict as! [String:String], at: 0)
            defaults.set(self.test, forKey: "TestPet")
            print(self.test)
            
            
        } else {
            print("AQUIIII")
            print(dict)
            let dict = petList["PetCreated"] as! NSDictionary
            defaults.set([dict], forKey: "TestPet")
        }
        
        loadTableData()
        
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
