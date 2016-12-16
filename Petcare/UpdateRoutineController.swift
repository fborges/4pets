//
//  ChangeRoutineController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 15/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import Foundation
import CZPicker
import UIKit
import DatePickerDialog


class UpdateRoutineController: UIViewController, UITableViewDelegate, UITableViewDataSource, CZPickerViewDelegate, CZPickerViewDataSource {
    
    var pet: Pet?
    var routineType: Int!
    var routineArray = [Routine]()
    var routine: Routine!
    var routineIdentifier: String!
    
    @IBOutlet weak var routineTableView: UITableView!
    
    
    let routineHeaders = ["Esthetic", "Health", "Recreation"]
    let routineNames = [["Bath", "Hair", "Claws", "Teeth"], ["Vaccination", "Deworming","Feeding"], ["Go out"]]
    let routineDefaultFrequency = [["Weekly", "Monthly", "Yearly", "Yearly"], ["Yearly", "Yearly", "Daily"],["Daily"]]
    let frequency = ["Daily", "3 times a week", "5 times a week", "Weekly", "Monthly", "Yearly"]
    let czpicker = CZPickerView(headerTitle: "Frequency", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    var buttonSender: UIButton!
    var badgeNumber: Int!
    
    
    override func viewDidLoad() {
        let dao = CoreDataDAO<Routine>()
        
        self.routineArray = dao.getAll()
        
        
        for pets in routineArray {
            
            if pets.pet == pet {
                
            }
            
            
            czpicker?.delegate = self
            czpicker?.dataSource = self
            czpicker?.allowMultipleSelection = false
            czpicker?.needFooterView = true
            
            
        }
        
        
    }
    
    func pickFrequency(sender: UIButton) {
        buttonSender = sender
        czpicker?.show()
        
    }
    
    func scheduleForFequency(hour: Int, minute: Int, amPm: String, frequency: String) -> DateComponents {
        var dateComponent = DateComponents()
        var fixedHour: Int!
        
        if amPm == "PM" {
            fixedHour = hour + 12
        } else {
            fixedHour = hour
        }
        
        switch frequency {
        case "Daily":
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        case "3 times a week":
            dateComponent.day = 3
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        case "5 times a week":
            dateComponent.day = 5
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        case "Weekly":
            dateComponent.day = 7
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        case "Monthly":
            dateComponent.day = 30
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        case "Yearly":
            dateComponent.day = 365
            dateComponent.hour = fixedHour
            dateComponent.minute = minute
        default:
            dateComponent.minute = 0
        }
        
        
        return dateComponent
    }
    
    func castDateToString(date: NSDate) -> String{
        
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        print(dateFormatter.string(from: date as Date))
        
        return dateFormatter.string(from: date as Date)
    }
    
    func pickHour(sender: UIButton) {
        DatePickerDialog().show("Hour", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .time, callback: { (date) in
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm"
            if let date = date {
                sender.setTitle(formatter.string(from: date), for: .normal)
                formatter.dateFormat = "a"
                let section = sender.tag / 100
                let row = sender.tag % 100
                let indexPath = IndexPath(row: row, section: section)
                let cell = self.routineTableView.cellForRow(at: indexPath) as! UpdateRoutineCell
                cell.routineAmPm.text = formatter.string(from: date)
                
            }
        })
    }
    
    // MARK : CZPicker
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return frequency.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return frequency[row]
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        buttonSender.setTitle(frequency[row], for: .normal)
    }
    
    // MARK : TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routineNames[section].count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.routineHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "updateRoutine", for: indexPath) as! UpdateRoutineCell
        
        // populatting info
        cell.routineName.text = self.routineNames[indexPath.section][indexPath.row]
        cell.routineFrequency.setTitle(self.routineDefaultFrequency[indexPath.section][indexPath.row], for: .normal)
        
        // adding buttons actions
        cell.routineHour.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        cell.routineHour.tag = (indexPath.section*100)+indexPath.row
        cell.routineFrequency.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        
        return cell
    }
}
