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

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    var session: WCSession!
    
    @IBOutlet var tableList: WKInterfaceTable!
    
    var petArray: [Pet] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if (WCSession.isSupported()){
            
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }
        
        requestPetList()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func requestPetList() {
        
        
        if(WCSession.isSupported()){
            
            session.sendMessage(["sendPetList":true], replyHandler: nil, errorHandler: nil)
            
            print("Está enviando a data maldita porém não chega pela falta de conectividade dessa bagaça")
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        petArray = (applicationContext["petList"] as? [Pet])!
        loadTableData()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        petArray = (message["petList"] as? [Pet])!
        loadTableData()
    }
    
    func loadTableData(){
        
        tableList.setNumberOfRows(petArray.count, withRowType: "firstRow")
        
        for (index, content) in petArray.enumerated(){
            
            //let row = tableList.rowController(at: index) as! PetRowController
           
            print(content)
            
        }
        
    }
    
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }

}
