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

class ConfirmPetViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CZPickerViewDelegate, CZPickerViewDataSource {
    
    // outlets
    @IBOutlet weak var routineTableView: UITableView!
    
    // local atributes
    let routineHeaders = ["Esthetic", "Health", "Recreation"]
    let routineNames = [["Bath", "Hair", "Claws", "Teeth"], ["Vaccination", "Deworming"], ["Go out"]]
    let routineDefaultFrequency = [["Weekly", "Monthly", "Yearly", "Yearly"], ["Yearly", "Yearly"],["Daily"]]
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
    
    
    func addTimeByFrequency(date: Date, frequency: String) -> Date {
        var dateComponent = DateComponents()
        let calendar = Calendar.autoupdatingCurrent
        var finalDate: Date!
        
        //        switch frequency {
        //        case "Daily":
        //            dateComponent.day = 1
        //        case "3 times a week":
        //            dateComponent.day = 3
        //        case "5 times a week":
        //            dateComponent.day = 5
        //        case "Weekly":
        //            dateComponent.day = 7
        //        case "Monthly":
        //            dateComponent.day = 30
        //        case "Yearly":
        //            dateComponent.day = 365
        //        default:
        //            dateComponent.day = 0
        //
        //        }
        //
        //        finalDate = calendar.date(byAdding: dateComponent, to: Date())
        
        dateComponent.second = 5
        finalDate = calendar.date(byAdding: dateComponent, to: Date())
        print(finalDate)
        return finalDate
    }
    
    func dateForFequency(hour: Int, minute: Int, amPm: String, frequency: String) -> Date {
        var dateComponent = DateComponents()
        let calendar = Calendar.autoupdatingCurrent
        var finalDate: Date!
        let todayDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        
        //        switch amPm {
        //        case "AM":
        //            dateComponent.hour = hour
        //            dateComponent.minute = minute
        //        case "PM":
        //            dateComponent.hour = hour + 12
        //            dateComponent.minute = minute
        //        default:
        //            dateComponent.hour = hour
        //            dateComponent.minute = minute
        //        }
        //
        //        switch frequency {
        //        case "Daily":
        //            dateComponent.day = 1
        //        case "3 times a week":
        //            dateComponent.day = 3
        //        case "5 times a week":
        //            dateComponent.day = 5
        //        case "Weekly":
        //            dateComponent.day = 7
        //        case "Monthly":
        //            dateComponent.day = 30
        //        case "Yearly":
        //            dateComponent.day = 365
        //        default:
        //            dateComponent.day = 0
        //
        //        }
        dateComponent.second = 20
        finalDate = calendar.date(byAdding: dateComponent, to: Date())
        // finalDate = calendar.date(byAdding: dateComponent, to: todayDate!)
        
        print(finalDate)
        return finalDate
    }
    
    
    func scheduleNotification(at date: Date) -> DateComponents{
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        return newComponents
    }
    
    func notificationLoop() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/aaaa h:mm"
        let routineArray = pet?.routine!.array as! [Routine]
        
        for routine in routineArray {
            if formatter.string(from: routine.date as! Date) == formatter.string(from: Date()) {
                // setting routine date
                
                let routineDate = addTimeByFrequency(date: routine.date as! Date, frequency: routine.frequency!)
                routine.date = routineDate as NSDate?
                
                // adding notification
                notification.body = "Just remind you about \((self.pet.name)!) \(routine.name)"
                notification.badge = NSNumber(value: badgeNumber + 1)
                let trigger = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: routineDate), repeats: false)
                
                let request = UNNotificationRequest(identifier: "routine3", content: notification, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "--")
                    }
                })
                
                let timer = Timer(fireAt: routineDate , interval: 0, target: self, selector: #selector(notificationLoop), userInfo: nil, repeats: false)
                RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            }
        }
        
    }
    
    func saveOnDAO() {
        
        var hour: Int!
        var minute: Int!
        var amPm: String!
        
        let routineDao = CoreDataDAO<Routine>()
        var routineCell: RoutineTableViewCell!
        
        for index in 0...1 {
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
                routine.name = "Recreation"
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
            
            let routineDate = dateForFequency(hour: hour!, minute: minute!, amPm: amPm! ,frequency: routineCell.routineFrequency.title(for: .normal)!) as NSDate?
            routine.date = Date() as NSDate? //routineDate
            
            // setting routine frequency
            routine.frequency = routineCell.routineFrequency.title(for: .normal)!
            
            // adding to pets array os baths
            let petRoutine = pet?.routine as! NSMutableOrderedSet
            petRoutine.add(routine)
            routineDao.insert(routine)
            
            // adding notification
            notification.badge = NSNumber(value: badgeNumber + 1)
            //let triggerRoutine = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let triggerRoutine = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: routineDate as! Date), repeats: false)
            let requestRoutine = UNNotificationRequest(identifier: "routine\(index)", content: notification, trigger: triggerRoutine)
            UNUserNotificationCenter.current().add(requestRoutine, withCompletionHandler:{ (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "--")
                }
            })
            
            
            let timer = Timer(fireAt: routineDate as! Date, interval: 0, target: self, selector: #selector(notificationLoop), userInfo: nil, repeats: false)
            //timer.fire()
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            
            
            
        }
        
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
        if section == 0 {
            return 4
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return self.routineHeaders[0]
        } else if section == 1 {
            return self.routineHeaders[1]
        } else {
            return self.routineHeaders[2]
        }
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
