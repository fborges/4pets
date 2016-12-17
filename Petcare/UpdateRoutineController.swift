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
import UserNotifications
import WatchConnectivity



class UpdateRoutineController: UIViewController, UITableViewDelegate, UITableViewDataSource, CZPickerViewDelegate, CZPickerViewDataSource {
    
    var pet: Pet!
    var routineType: Int!
    var routineArray = [Routine]()
    var routineOfPetArray = [Routine]()
    var routine: Routine!
    var routineIdentifier: String!
    var positionOfUpdate = 0


    @IBOutlet weak var routineTableView: UITableView!
    
    
    let routineHeaders = ["Esthetic", "Health", "Recreation"]
    let routineNames = [["Bath", "Hair", "Claws", "Teeth"], ["Vaccination", "Deworming","Feeding"], ["Go out"]]
    var routineDefaultFrequency = [[String]]()
    var routineHour = [[String]]()
    var routineAmPm = [[String]]()
    let frequency = ["Daily", "3 times a week", "5 times a week", "Weekly", "Monthly", "Yearly"]
    let czpicker = CZPickerView(headerTitle: "Frequency", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    var buttonSender: UIButton!
    
    let notification = UNMutableNotificationContent()

    var badgeNumber: Int!
    
    override func viewDidLoad() {
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
        
        let dao = CoreDataDAO<Routine>()
        let application = UIApplication.shared
        badgeNumber = application.applicationIconBadgeNumber
        self.routineArray = dao.getAll()
        var position = 0
        for pets in routineArray {
            
            if pets.pet == pet {
                
                routineOfPetArray.insert(pets, at: position)
                position += 1
            }
            
        }
        
        
        self.routineDefaultFrequency = [[self.routineOfPetArray[0].frequency!,self.routineOfPetArray[1].frequency!,self.routineOfPetArray[2].frequency!, self.routineOfPetArray[3].frequency!],
            [self.routineOfPetArray[4].frequency!,self.routineOfPetArray[5].frequency!,self.routineOfPetArray[6].frequency!],
            [self.routineOfPetArray[7].frequency!]]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        
        self.routineAmPm = [[dateFormatter.string(from: self.routineOfPetArray[0].date! as Date),
                            dateFormatter.string(from: self.routineOfPetArray[1].date! as Date),
                            dateFormatter.string(from: self.routineOfPetArray[2].date! as Date),
                            dateFormatter.string(from: self.routineOfPetArray[3].date! as Date)],
                            [dateFormatter.string(from: self.routineOfPetArray[4].date! as Date),
                            dateFormatter.string(from: self.routineOfPetArray[5].date! as Date),
                            dateFormatter.string(from: self.routineOfPetArray[6].date! as Date)],
                            [dateFormatter.string(from: self.routineOfPetArray[7].date! as Date),]]
        
        dateFormatter.dateFormat = "h:mm"
        
        self.routineHour = [[dateFormatter.string(from: self.routineOfPetArray[0].date! as Date),dateFormatter.string(from: self.routineOfPetArray[1].date! as Date),dateFormatter.string(from: self.routineOfPetArray[2].date! as Date), dateFormatter.string(from: self.routineOfPetArray[3].date! as Date)],
            [dateFormatter.string(from: self.routineOfPetArray[4].date! as Date),dateFormatter.string(from: self.routineOfPetArray[5].date! as Date),dateFormatter.string(from: self.routineOfPetArray[6].date! as Date)],
            [dateFormatter.string(from: self.routineOfPetArray[7].date! as Date)]]
        
        czpicker?.delegate = self
        czpicker?.dataSource = self
        czpicker?.allowMultipleSelection = false
        czpicker?.needFooterView = true
        
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
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
    
    func prepareToSendToWatch(){
        
        
        let bath = ["Type": (pet?.routine?.array[0] as! Routine).name!, "frequency": (pet?.routine?.array[0] as! Routine).frequency!, "time": castDateToString(date: (pet?.routine?.array[0] as! Routine).date!), "petName": (pet?.name!)! as String] as [String : Any]
        
        let hair = ["Type": (pet?.routine?.array[1] as! Routine).name!, "frequency": (pet?.routine?.array[1] as! Routine).frequency!, "time": castDateToString(date: (pet?.routine?.array[1] as! Routine).date!), "petName": (pet?.name!)! as String] as [String : Any]
        
        let recreation = ["Type": (pet.routine?.array[7] as! Routine).name!, "frequency": (pet.routine?.array[7] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[7] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let food = ["Type": (pet.routine?.array[6] as! Routine).name!, "frequency": (pet.routine?.array[6] as! Routine).frequency!, "time": castDateToString(date: (pet.routine?.array[6] as! Routine).date!), "petName": pet.name!] as [String : Any]
        
        let dictArray = ["Bath":bath, "Recreation":recreation, "Hair":hair, "Feeding":food]
        
        WCSession.default().transferUserInfo(["Created": dictArray, "TypeSended": "RoutineUpdate"])
        
        
    }
    
    func saveOnDAO() {
        
        var hour: Int!
        var minute: Int!
        var amPm: String!
        var frequencyString: String!
        
        let routineDao = CoreDataDAO<Routine>()
        var routineCell: UpdateRoutineCell!
        
        for index in 0...7 {
            let routine = routineDao.getByID(routineArray[positionOfUpdate].objectID)
            routine.pet = self.pet
            
            switch index {
            case 0:
                routine.name = "Bath"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) bath"
                
            case 1:
                routine.name = "Hair"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) hair"
                
            case 2:
                routine.name = "Claws"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) claws"
                
            case 3:
                routine.name = "Teeth"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) teeth"
                
            case 4:
                routine.name = "Vaccination"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) vaccination"
                
            case 5:
                routine.name = "Deworming"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 1, section: 1)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) deworming"
                
            case 6:
                routine.name = "Feeding"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 2, section: 1)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) feeding"
                
            case 7:
                routine.name = "Go out"
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as! UpdateRoutineCell
                notification.body = "Just remind you about \((self.pet.name)!) recreation"
                
            default:
                routineCell = routineTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UpdateRoutineCell
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

            var routineToUpdate = routineDao.getByID(routineArray[positionOfUpdate].objectID)
            print(castDateToString(date: routineToUpdate.date! ))
            routineToUpdate = routine
            print(castDateToString(date: routineToUpdate.date! ))

            routineDao.update(routineToUpdate)
            print(castDateToString(date: routineToUpdate.date! ))

            
            // adding notification
            notification.badge = NSNumber(value: badgeNumber + 1)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: routine.name! , content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "--")
                }
            })
            
            positionOfUpdate += 1
        }
        
        prepareToSendToWatch()
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()

            saveOnDAO()
        
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
        
        cell.routineHour.setTitle(self.routineHour[indexPath.section][indexPath.row], for: .normal)
        cell.routineAmPm.text = self.routineAmPm[indexPath.section][indexPath.row]
        // adding buttons actions
        cell.routineHour.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        cell.routineHour.tag = (indexPath.section*100)+indexPath.row
        cell.routineFrequency.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        
        return cell
    }
}
