//
//  ActivityController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 09/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import WatchKit


class ActivityController: WKInterfaceController{
    
    
    @IBOutlet var activityImage: WKInterfaceImage!
    
    @IBOutlet var activityLabel: WKInterfaceLabel!
    
    @IBOutlet var activityDateLabel: WKInterfaceLabel!
    
    @IBOutlet var countdownTimer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        
        //INSERIR A DATA A PARTIR DA DATA PASSADA PELA ATIVIDADE EM QUESTÃO
        self.countdownTimer.setDate(NSDate(timeIntervalSinceNow: 10) as Date)
        self.countdownTimer.start()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
