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
    
    var activityDate: Date!
    
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
        
        let data  = (dict!["time"] as? String!)!
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        self.activityDateLabel.setText(dateFormatter.string(from: activityDate!))
        
    }
    
    
}
