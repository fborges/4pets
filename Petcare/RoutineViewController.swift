//
//  BathViewController.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import UserNotifications

class RoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // class atributes
    var pet: Pet?
    var routineType: Int!
    var routineArray = [Routine]()
    var routine: Routine!
    var routineIdentifier: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch routineType {
        case 0:
            routineIdentifier = "Bath"
            routine = pet?.routine!.array[0] as! Routine
            routineArray.append(pet?.routine!.array[0] as! Routine)
        case 1:
            routineIdentifier = "Hair"
            routine = pet?.routine!.array[1] as! Routine
            routineArray.append(pet?.routine!.array[1] as! Routine)
        case 2:
            routineIdentifier = "Claws"
            routine = pet?.routine!.array[2] as! Routine
            routineArray.append(pet?.routine!.array[2] as! Routine)
        case 3:
            routineIdentifier = "Teeth"
            routine = pet?.routine!.array[3] as! Routine
            routineArray.append(pet?.routine!.array[3] as! Routine)
        case 4:
            routineIdentifier = "Vaccination"
            routine = pet?.routine!.array[4] as! Routine
            routineArray.append(pet?.routine!.array[4] as! Routine)
        case 5:
            routineIdentifier = "Deworming"
            routine = pet?.routine!.array[5] as! Routine
            routineArray.append(pet?.routine!.array[5] as! Routine)
        case 6:
            routineIdentifier = "Feeding"
            routine = pet?.routine!.array[6] as! Routine
            routineArray.append(pet?.routine!.array[6] as! Routine)
        case 7:
            routineIdentifier = "Recreation"
            routine = pet?.routine!.array[7] as! Routine
            routineArray.append(pet?.routine!.array[7] as! Routine)
        default:
            print("error")
        }
        
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
    
    
    
    func updateHourAndFrequency() {
        
        var hour: Int!
        var minute: Int!
        var amPm: String!
        var frequency: String!
       
        let calendar = Calendar.autoupdatingCurrent
        let notification = UNMutableNotificationContent()
        
            notification.body = "Just remind you about \((self.pet?.name)!) \(routine.name)"
           // notification.badge = NSNumber(value: badgeNumber + 1)
        
        // setting routine date
//            hour = Int(((routineCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
//            minute = Int(((routineCell.routineHour.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
//            amPm = routineCell.routineAmPm.text
        
            let dateComponents = scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm! ,frequency: frequency)
            routine.date = calendar.date(from: dateComponents) as NSDate? //routineTime
            
            // setting routine frequency
            routine.frequency = frequency
            
            // updating notification
        

            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [routineIdentifier])
        
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: routineIdentifier, content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                if error != nil {
                    print(error?.localizedDescription ?? "--")
                }
            })
    }

    
    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routineArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy h:mm"
        
        let item = routineArray[indexPath.row]
        cell.textLabel?.text = dateFormatter.string( from: item.date as! Date )
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dao = CoreDataDAO<Routine>()
            let routine = routineArray[indexPath.row]
            
            dao.delete(routine)
            routineArray.remove(at: indexPath.row)
            //pet?.bath.a
            tableView.reloadData()
        }
    }
}
