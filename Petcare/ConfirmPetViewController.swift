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
        //saveOnDAO()
    }
    
    func dateForFequency(hour: Int, minute: Int, amPm: String, frequency: String) -> Date {
        var dateComponent = DateComponents()
        let calendar = Calendar.autoupdatingCurrent
        var finalDate: Date!
        let todayDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())

        switch amPm {
        case "AM":
            dateComponent.hour = hour
            dateComponent.minute = minute
        case "PM":
            dateComponent.hour = hour + 12
            dateComponent.minute = minute
        default:
            dateComponent.hour = hour
            dateComponent.minute = minute
        }
        
        switch frequency {
        case "Daily":
            dateComponent.day = 1
        case "3 times a week":
            dateComponent.day = 3
        case "5 times a week":
            dateComponent.day = 5
        case "Weekly":
            dateComponent.day = 7
        case "Monthly":
            dateComponent.day = 30
        case "Yearly":
            dateComponent.day = 365
        default:
            dateComponent.day = 0
            
        }
   
        
        finalDate = calendar.date(byAdding: dateComponent, to: todayDate!)
        
        print(finalDate)
        return finalDate
    }
    
        
    func scheduleNotification(at date: Date) -> DateComponents{
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        return newComponents
    }
    
//    func saveOnDAO() {
//
//        var hour: Int!
//        var minute: Int!
//        var amPm: String!
//        //BATH
//            let daoBath = CoreDataDAO<Bath>()
//            let bath = daoBath.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((bathCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((bathCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//
//            let bathDate = dateForFequency(hour: hour!, minute: minute!, amPm: bathCell.routineAmPm.text! ,frequency: bathCell.routineFrequency.title(for: .normal)!) as NSDate?
//            bath.date = bathDate
//            bath.pet = self.pet
//
//            // adding to pets array os baths
//            let petBaths = pet?.bath as! NSMutableOrderedSet
//            petBaths.add(bath)
//            
//            daoBath.insert(bath)
//            
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) bath"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerBath = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: bathDate as! Date), repeats: false)
//            let requestBath = UNNotificationRequest(identifier: "bath", content: notification, trigger: triggerBath)
//            UNUserNotificationCenter.current().add(requestBath, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//        
//        // HAIR
//            let daoHair = CoreDataDAO<Hair>()
//            let hair = daoHair.new()
//        
//            let hairCell = routineTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! RoutineTableViewCell // Hair
//            hour = Int(((hairHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((hairHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let hairDate = dateForFequency(hour: hour!, minute: minute!, frequency: hairFrequencyBtn.title(for: .normal)!) as NSDate?
//            hair.date = hairDate
//            hair.pet = self.pet
//            
//            // adding to pets array os baths
//            let petHair = pet?.hair as! NSMutableOrderedSet
//            petHair.add(hair)
//            
//            daoHair.insert(hair)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) hair"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerHair = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: hairDate as! Date), repeats: false)
//            let requestHair = UNNotificationRequest(identifier: "hair", content: notification, trigger: triggerHair)
//            UNUserNotificationCenter.current().add(requestHair, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//        
//        //TEETH
//            let daoTeeth = CoreDataDAO<Teeth>()
//            let teeth = daoTeeth.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((teethHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((teethHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let teethDate = dateForFequency(hour: hour!, minute: minute!, frequency: teethFrequencyBtn.title(for: .normal)!) as NSDate?
//            teeth.date = teethDate
//            teeth.pet = self.pet
//            
//            // adding to pets array os baths
//            let petTeeth = pet?.teeth as! NSMutableOrderedSet
//            petTeeth.add(teeth)
//            
//            daoTeeth.insert(teeth)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) teeths"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerTeeth = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: teethDate as! Date), repeats: false)
//            let requestTeeth = UNNotificationRequest(identifier: "teeth", content: notification, trigger: triggerTeeth)
//            UNUserNotificationCenter.current().add(requestTeeth, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//        
//        //NAILS
//            let daoNails = CoreDataDAO<Nails>()
//            let nails = daoNails.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((nailsHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((nailsHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let nailsDate = dateForFequency(hour: hour!, minute: minute!, frequency: nailsFrequencyBtn.title(for: .normal)!) as NSDate?
//            nails.date = nailsDate
//            nails.pet = self.pet
//            
//            // adding to pets array os baths
//            let petNails = pet?.nails as! NSMutableOrderedSet
//            petNails.add(nails)
//            
//            daoNails.insert(nails)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) nails"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerNails = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: nailsDate as! Date), repeats: false)
//            let requestNails = UNNotificationRequest(identifier: "nails", content: notification, trigger: triggerNails)
//            UNUserNotificationCenter.current().add(requestNails, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//            
//        //VACCINATION
//            let daoVaccination = CoreDataDAO<Vaccination>()
//            let vaccination = daoVaccination.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((vaccinationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((vaccinationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let vaccinationDate = dateForFequency(hour: hour!, minute: minute!, frequency: vaccinationFrequencyBtn.title(for: .normal)!) as NSDate?
//            vaccination.date = vaccinationDate
//            vaccination.pet = self.pet
//            
//            // adding to pets array os baths
//            let petVaccination = pet?.vaccination as! NSMutableOrderedSet
//            petVaccination.add(vaccination)
//            
//            daoVaccination.insert(vaccination)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) vaccination"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerVaccination = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: vaccinationDate as! Date), repeats: false)
//            let requestVaccination = UNNotificationRequest(identifier: "vaccination", content: notification, trigger: triggerVaccination)
//            UNUserNotificationCenter.current().add(requestVaccination, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//        
//        //DEWORMING
//            let daoDeworming = CoreDataDAO<Deworming>()
//            let deworming = daoDeworming.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((dewormingHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((dewormingHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let dewormingDate = dateForFequency(hour: hour!, minute: minute!, frequency: dewormingFrequencyBtn.title(for: .normal)!) as NSDate?
//            deworming.date = dewormingDate
//            deworming.pet = self.pet
//            
//            // adding to pets array os baths
//            let petDeworming = pet?.deworming as! NSMutableOrderedSet
//            petDeworming.add(deworming)
//            
//            daoDeworming.insert(deworming)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) deworming"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerDeworming = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: dewormingDate as! Date), repeats: false)
//            let requestDeworming = UNNotificationRequest(identifier: "deworming", content: notification, trigger: triggerDeworming)
//            UNUserNotificationCenter.current().add(requestDeworming, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//        
//        //RECREATION
//            let daoRecreation = CoreDataDAO<Recreation>()
//            let recreation = daoRecreation.new()
//        
//            let bathCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RoutineTableViewCell // Bath
//            hour = Int(((recreationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((recreationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            
//            let recreationDate = dateForFequency(hour: hour!, minute: minute!, frequency: recreationFrequencyBtn.title(for: .normal)!) as NSDate?
//            recreation.date = recreationDate
//            recreation.pet = self.pet
//            
//            // adding to pets array os baths
//            let petRecreation = pet?.recreation as! NSMutableOrderedSet
//            petRecreation.add(recreation)
//            
//            daoRecreation.insert(recreation)
//        
//            // adding notification
//            notification.body = "Just remind you about \((self.pet.name)!) recreation"
//            notification.badge = NSNumber(value: badgeNumber + 1)
//            let triggerRecreation = UNCalendarNotificationTrigger(dateMatching: scheduleNotification(at: recreationDate as! Date), repeats: false)
//            let requestRecreation = UNNotificationRequest(identifier: "recreation", content: notification, trigger: triggerRecreation)
//            UNUserNotificationCenter.current().add(requestRecreation, withCompletionHandler:{ (error) in
//                if error != nil {
//                    print(error?.localizedDescription ?? "--")
//                }
//            })
//    }
    
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
