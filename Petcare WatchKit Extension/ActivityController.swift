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
    
    var dateCountdown: Date!
    
    var type: String!
    
    @IBOutlet var activityImage: WKInterfaceImage!
    
    @IBOutlet var activityLabel: WKInterfaceLabel!
    
    @IBOutlet var countdownTimer: WKInterfaceTimer!
    
    @IBOutlet var activityDateLabel: WKInterfaceLabel!
    
    @IBOutlet var frequencyLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let dict = context! as? NSDictionary
       
        self.activityLabel.setText(dict?["Type"] as? String)
        self.activityDateLabel.setText((dict?["time"] as? String))
        self.frequencyLabel.setText((dict?["frequency"] as? String)
        )
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        
        self.dateCountdown = dateFormatter.date(from: (dict?["time"] as? String)!)
        
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
    
}
