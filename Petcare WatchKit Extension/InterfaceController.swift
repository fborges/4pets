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
    
    var petArray: [PetWatch] = []
    
    var test: [String] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        WatchConnectivityManager.sharedConnectivityManager.delegate = self

        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let testDefaults = UserDefaults.standard.array(forKey: "testDefaults") as? [PetWatch] {
            
            
        } else {
            
            UserDefaults.standard.set("Teste", forKey: "testDefaults")
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
  
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithPetList petList: [String : Any]) {
        
        let dict = petList["pets"] as! NSDictionary

        let pet = PetWatch(name: dict["Name"] as! String)      
        
        loadTableData()
        
        print(dict["Type"]!)
        
    }
    
    func loadTableData(){
        
        tableList.setNumberOfRows(test.count, withRowType: "firstRow")
        
        for (index, content) in test.enumerated(){
            
            print(content)
            
        let row = tableList.rowController(at: index) as! PetRowController
           
            print(content)
            
        }
        
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
