//
//  PetDashboardViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CKCircleMenuView
import WatchConnectivity
import UserNotifications

class PetDashboardViewController: UIViewController, CKCircleMenuDelegate, WatchConnectivityManagerPhoneDelegate {
    
    
    
    // outlets
    @IBOutlet weak var petPhoto: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petBrithday: UILabel!
    @IBOutlet weak var petSexImageView: UIImageView!
    
    // internal variables
    var pet: Pet!
    private var circleMenuView: CKCircleMenuView!
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithRoutine routineType: String, Routine: [String : String], amPM: String) {
        
        DispatchQueue.main.async {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let date  = Routine["date"]
            let data = dateFormatter.date(from: date!) as NSDate?
            dateFormatter.dateFormat = "h"
          
            let hour = Int(dateFormatter.string(from: data as! Date))
            

            dateFormatter.dateFormat = "mm"
            let minute = Int(dateFormatter.string(from: data as! Date))
            
            let amPm = amPM
            let frequencyString = Routine["frequency"]

            let notification = UNMutableNotificationContent()
            var badgeNumber: Int!
            
            notification.title = "4Pets"
            let application = UIApplication.shared
            badgeNumber = application.applicationIconBadgeNumber
            
            let petName = Routine["pet"]
            
            let dao = CoreDataDAO<Routine>()
            let routine = dao.getAll()
            var routineOfPetArray: [Routine] = []
            var position = 0
            for pets in routine {
                
                if pets.pet?.name == petName {
                    routineOfPetArray.insert(pets, at: position)
                    position += 1
                }
                
            }
            
            
            if routineType == "Bath" {
                
                let routineToUpdate = dao.getByID(routineOfPetArray[0].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                
    
                let dateComponents = self.scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm ,frequency: frequencyString!)
                

                let calendar = Calendar.autoupdatingCurrent
                dateFormatter.dateFormat = "h:mm a"
                
                routineToUpdate.date = calendar.date(from: dateComponents) as NSDate?
                dao.update(routineToUpdate)
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

                let requestName = routineType + Routine["pet"]!
                
                notification.body = "Just remind you about \((Routine["pet"]!)) bath"
                
                notification.badge = NSNumber(value: badgeNumber + 1)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: requestName  , content: notification, trigger: trigger)

                UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                    if error != nil {
                        self.view.backgroundColor = UIColor.red

                        print(error?.localizedDescription ?? "--")
                    }
                })
                

            }
            
            
            if routineType == "Hair"{
                
                let routineToUpdate = dao.getByID(routineOfPetArray[1].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                
                
                let dateComponents = self.scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm ,frequency: frequencyString!)
                
                
                let calendar = Calendar.autoupdatingCurrent
                dateFormatter.dateFormat = "h:mm a"
                
                routineToUpdate.date = calendar.date(from: dateComponents) as NSDate?
                dao.update(routineToUpdate)
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                let requestName = routineType + Routine["pet"]!
                
                notification.body = "Just remind you about \((Routine["pet"]!)) hair"
                
                notification.badge = NSNumber(value: badgeNumber + 1)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: requestName  , content: notification, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                    if error != nil {
                        self.view.backgroundColor = UIColor.red
                        
                        print(error?.localizedDescription ?? "--")
                    }
                })

                
                
            }
            
            if routineType == "Feeding"{
                
                let routineToUpdate = dao.getByID(routineOfPetArray[6].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                
                
                let dateComponents = self.scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm ,frequency: frequencyString!)
                
                
                let calendar = Calendar.autoupdatingCurrent
                dateFormatter.dateFormat = "h:mm a"
                
                routineToUpdate.date = calendar.date(from: dateComponents) as NSDate?
                dao.update(routineToUpdate)
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                let requestName = routineType + Routine["pet"]!
                
                notification.body = "Just remind you about \((Routine["pet"]!)) feeding"
                
                notification.badge = NSNumber(value: badgeNumber + 1)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: requestName  , content: notification, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                    if error != nil {
                        self.view.backgroundColor = UIColor.red
                        
                        print(error?.localizedDescription ?? "--")
                    }
                })

            }
            
            if routineType == "Recreation"{
                
                let routineToUpdate = dao.getByID(routineOfPetArray[7].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                
                
                let dateComponents = self.scheduleForFequency(hour: hour!, minute: minute!, amPm: amPm ,frequency: frequencyString!)
                
                
                let calendar = Calendar.autoupdatingCurrent
                dateFormatter.dateFormat = "h:mm a"
                
                routineToUpdate.date = calendar.date(from: dateComponents) as NSDate?
                dao.update(routineToUpdate)
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                let requestName = routineType + Routine["pet"]!
                
                notification.body = "Just remind you about \((Routine["pet"]!)) recreation"
                
                notification.badge = NSNumber(value: badgeNumber + 1)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(identifier: requestName  , content: notification, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler:{ (error) in
                    if error != nil {
                        self.view.backgroundColor = UIColor.red
                        
                        print(error?.localizedDescription ?? "--")
                    }
                })

                
            }
            
            
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
    
    
    func getByPet(pet: Pet) -> [Routine]{
        
        let dao = CoreDataDAO<Routine>()
        
        return dao.getAll()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        WatchConnectivityManager.sharedConnectivityManager.delegate = self
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
        //let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        // populatting outlets
        self.petPhoto.image = UIImage(data: pet.photo as! Data)
        self.petName.text = pet.name
        self.petBreed.text = pet.breed
        self.petBrithday.text = dateFormatter.string( from: pet.birthdate! as Date )
        //z  self.petSex.text = pet.sex
        //testing
        
        switch pet.sex! {
        case "Male":
            petSexImageView.image = UIImage(named: "male")
        case "Female":
            petSexImageView.image = UIImage(named: "female")
        default:
            print("No such sex")
        }
        
    }
    
    @IBAction func selectRoutine(_ sender: Any) {
        
        performSegue(withIdentifier: "updateRoutineViewController", sender: nil)
        //        configurePopUpMenu()
        //        self.circleMenuView!.openMenu()
        
    }
    
    
    
//    func configurePopUpMenu() {
//        // setting menu to view center
//        let tPoint = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY + self.view.frame.midY/3)
//        let tOrigin = self.view.convert(tPoint, from: self.view)
//        
//        // seetting menu attributes
//        var tOptions = Dictionary<String, AnyObject>()
//        tOptions[CIRCLE_MENU_OPENING_DELAY] = 0.1 as AnyObject?
//        tOptions[CIRCLE_MENU_MAX_ANGLE] = 360.0 as AnyObject?
//        tOptions[CIRCLE_MENU_RADIUS] = 100.0 as AnyObject?
//        tOptions[CIRCLE_MENU_DIRECTION] = Int(CircleMenuDirectionUp.rawValue) as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4) as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8) as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_BORDER] = UIColor.white as AnyObject?
//        tOptions[CIRCLE_MENU_DEPTH] = 2.0 as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_RADIUS] = 35.0 as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_BORDER_WIDTH] = 2.0 as AnyObject?
//        tOptions[CIRCLE_MENU_TAP_MODE] = true as AnyObject?
//        tOptions[CIRCLE_MENU_LINE_MODE] = false as AnyObject?
//        tOptions[CIRCLE_MENU_BUTTON_TINT] = false as AnyObject?
//        tOptions[CIRCLE_MENU_BACKGROUND_BLUR] = false as AnyObject?
//        
//        
//        self.circleMenuView = CKCircleMenuView(atOrigin: tOrigin, usingOptions: tOptions, withImageArray: self.circleMenuImageArray)
//        self.view.addSubview(self.circleMenuView!)
//        self.circleMenuView!.delegate = self
//        
//    }
    
    func circleMenuActivatedButton(with anIndex: Int32) {
        performSegue(withIdentifier: "updateRoutineViewController", sender: anIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateRoutineViewController" {
            let viewController = segue.destination as! UpdateRoutineController
            
            viewController.pet = self.pet
        }
        
        
        
    }
    
    
    func formDate() -> DateComponents {
         var dateComponent = DateComponents()
        dateComponent.hour = 09
        dateComponent.minute = 18
        
        return dateComponent
    }
    
    
}
