//
//  ConfirmPetViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CZPicker
import DatePickerDialog
import UserNotifications
import WatchConnectivity


class ConfirmPetViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CZPickerViewDelegate, CZPickerViewDataSource {
    
    // outlets
    @IBOutlet weak var routineTableView: UITableView!
    
    // local atributes
    let routineHeaders = ["Esthetic", "Health", "Recreation"]
    let routineNames = [["Bath", "Hair", "Claws", "Teeth"], ["Vaccination", "Deworming","Feeding"], ["Go out"]]
    let routineDefaultFrequency = [["Weekly", "Monthly", "Yearly", "Yearly"], ["Yearly", "Yearly", "Daily"],["Daily"]]
    let frequency = ["Daily", "3 times a week", "5 times a week", "Weekly", "Monthly", "Yearly"]
    var pet: Pet!
    let czpicker = CZPickerView(headerTitle: "Frequency", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    var buttonSender: UIButton!
    let notification = UNMutableNotificationContent()
    var badgeNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notification
        notification.title = "PetCare"
        let application = UIApplication.shared
        badgeNumber = application.applicationIconBadgeNumber
        
        // picker settings
        czpicker?.delegate = self
        czpicker?.dataSource = self
        czpicker?.allowMultipleSelection = false
        czpicker?.needFooterView = true
        
        
    }
    
    func pickFrequency(sender: UIButton) {
        buttonSender = sender
        czpicker?.show()
        
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
                let cell = self.routineTableView.cellForRow(at: indexPath) as! RoutineTableViewCell
                cell.routineAmPm.text = formatter.string(from: date)
                
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveOnDAO()
        
    }
    
    func prepareToSendToWatch(){
        
        
        let bath = ["Type": (pet.routine?.array[0] as! Routine).name!, "frequency": (pet.routine?.array[0] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[0] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let hair = ["Type": (pet.routine?.array[1] as! Routine).name!, "frequency": (pet.routine?.array[1] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[1] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let recreation = ["Type": (pet.routine?.array[7] as! Routine).name!, "frequency": (pet.routine?.array[7] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[7] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let food = ["Type": (pet.routine?.array[6] as! Routine).name!, "frequency": (pet.routine?.array[6] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[6] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let dictArray = ["Bath":bath, "Recreation":recreation, "Hair":hair, "Feeding":food]
        
        WCSession.default().transferUserInfo(["Created": dictArray, "TypeSended": "Routine"])
        
        
    }
    
    func castDateToString(date: NSDate) -> String{
        
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        print(dateFormatter.string(from: date as Date))
        return dateFormatter.string(from: date as Date)
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
    
    
    
    func saveOnDAO() {
        
        var hour: Int!
        var minute: Int!
        var amPm: String!
        var frequencyString: String!
        
        let routineDao = CoreDataDAO<Routine>()
        var routineCell: RoutineTableViewCell!
        
        for index in 0...7 {
            let routine = routineDao.new()
            routine.pet = self.pet
            
            switch index {
            case 0:
                routine.name = "Bath"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) bath"
                
            case 1:
                routine.name = "Hair"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) hair"
                
            case 2:
                routine.name = "Claws"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) claws"
                
            case 3:
                routine.name = "Teeth"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) teeth"
                
            case 4:
                routine.name = "Vaccination"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) vaccination"
                
            case 5:
                routine.name = "Deworming"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) deworming"
                
            case 6:
                routine.name = "Feeding"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 2, section: 1)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) feeding"

            case 7:
                routine.name = "Go out"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) recreation"
                
            default:
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell
                notification.body = "Just remind you about \((self.pet.name)!) bath"
                
            }
            
            // setting routine date
            hour = Int(((routineCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
            minute = Int(((routineCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
            amPm = routineCell.routineAmPm.text
            frequencyString = routineCell.routineFrequency.title(for: .normal)!
            
            let dateComponents = scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm! ,frequency: frequencyString)
            let calendar = Calendar.autoupdatingCurrent
            routine.date = calendar.date(from: dateComponents) as NSDate? //routineTime
            
            // setting routine frequency
            routine.frequency = frequencyString
            
            // adding to pets array os baths
            let petRoutine = pet?.routine as! NSMutableOrderedSet
            petRoutine.add(routine)
            routineDao.insert(routine)
            
            // adding notification
            notification.badge = NSNumber(value: badgeNumber + 1)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: routine.name! , content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "--")
                }
            })
            
            
        }
        
        prepareToSendToWatch()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "routineCell", for: indexPath) as! RoutineTableViewCell
        
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
