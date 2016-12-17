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
    let circleMenuImageArray = [ #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "hair"), #imageLiteral(resourceName: "claws"), #imageLiteral(resourceName: "teeth"), #imageLiteral(resourceName: "vaccination"), #imageLiteral(resourceName: "deworming"), #imageLiteral(resourceName: "feeding"), #imageLiteral(resourceName: "recreation")]
    
    func watchConnectivityManager(_ watchConnectivityManager: WatchConnectivityManager, updateWithRoutine routineType: String, Routine: [String : String]) {
        
        DispatchQueue.main.async {
            
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
                let data  = Routine["date"]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                routineToUpdate.date = dateFormatter.date(from: data!) as NSDate?
                dao.update(routineToUpdate)

//                if routine[0].pet == self.pet{
//                    
//                    
//                    
//                    dao.update(routine[0])
//                    //routineDao.getByID(routineArray[positionOfUpdate].objectID)
//                    //notification.body = "Just remind you about \((self.pet.name)!) deworming"
//                }
            }
            
            
            if routineType == "Hair"{
                
                self.view.backgroundColor = UIColor.red
                
                let routineToUpdate = dao.getByID(routineOfPetArray[1].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                let data  = Routine["date"]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                routineToUpdate.date = dateFormatter.date(from: data!) as NSDate?
                
                dao.update(routineToUpdate)
                
                
            }
            
            if routineType == "Feeding"{
                
                self.view.backgroundColor = UIColor.red
                
                let routineToUpdate = dao.getByID(routineOfPetArray[6].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                let data  = Routine["date"]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                routineToUpdate.date = dateFormatter.date(from: data!) as NSDate?
                
                dao.update(routineToUpdate)
            }
            
            if routineType == "Recreation"{
                
                self.view.backgroundColor = UIColor.red
                
                let routineToUpdate = dao.getByID(routineOfPetArray[7].objectID)
                
                routineToUpdate.name = Routine["name"]
                routineToUpdate.frequency = Routine["frequency"]
                let data  = Routine["date"]
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
                
                routineToUpdate.date = dateFormatter.date(from: data!) as NSDate?
                
                dao.update(routineToUpdate)
                
            }
            
            
        }
        
        
        
    }
    
    func teste(){
        
        let dao = CoreDataDAO<Routine>()
        let routine = dao.getAll()
        var routineOfPetArray: [Routine] = []
        var position = 0
        
        for pets in routine {
            
            if pets.pet?.name == self.pet.name {
                routineOfPetArray.insert(pets, at: position)
                position += 1
            }
            
        }
        
        
        print(routineOfPetArray)
    }
    
    
    func getByPet(pet: Pet) -> [Routine]{
        
        let dao = CoreDataDAO<Routine>()
        
        return dao.getAll()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WatchConnectivityManager.sharedConnectivityManager.delegate = self
        
        let routine = getByPet(pet: self.pet)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        let data = dateFormatter.string(from: routine[0].date! as Date)
        
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
        
        self.teste()
    }
    
    @IBAction func selectRoutine(_ sender: Any) {
        
        performSegue(withIdentifier: "updateRoutineViewController", sender: nil)
        //        configurePopUpMenu()
        //        self.circleMenuView!.openMenu()
        
    }
    
    
    
    func configurePopUpMenu() {
        // setting menu to view center
        let tPoint = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY + self.view.frame.midY/3)
        let tOrigin = self.view.convert(tPoint, from: self.view)
        
        // seetting menu attributes
        var tOptions = Dictionary<String, AnyObject>()
        tOptions[CIRCLE_MENU_OPENING_DELAY] = 0.1 as AnyObject?
        tOptions[CIRCLE_MENU_MAX_ANGLE] = 360.0 as AnyObject?
        tOptions[CIRCLE_MENU_RADIUS] = 100.0 as AnyObject?
        tOptions[CIRCLE_MENU_DIRECTION] = Int(CircleMenuDirectionUp.rawValue) as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_NORMAL] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4) as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_BACKGROUND_ACTIVE] = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8) as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_BORDER] = UIColor.white as AnyObject?
        tOptions[CIRCLE_MENU_DEPTH] = 2.0 as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_RADIUS] = 35.0 as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_BORDER_WIDTH] = 2.0 as AnyObject?
        tOptions[CIRCLE_MENU_TAP_MODE] = true as AnyObject?
        tOptions[CIRCLE_MENU_LINE_MODE] = false as AnyObject?
        tOptions[CIRCLE_MENU_BUTTON_TINT] = false as AnyObject?
        tOptions[CIRCLE_MENU_BACKGROUND_BLUR] = false as AnyObject?
        
        
        self.circleMenuView = CKCircleMenuView(atOrigin: tOrigin, usingOptions: tOptions, withImageArray: self.circleMenuImageArray)
        self.view.addSubview(self.circleMenuView!)
        self.circleMenuView!.delegate = self
        
    }
    
    func circleMenuActivatedButton(with anIndex: Int32) {
        performSegue(withIdentifier: "updateRoutineViewController", sender: anIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateRoutineViewController" {
            let viewController = segue.destination as! UpdateRoutineController
            
            viewController.pet = self.pet
        }
        
        
        
    }
    
    
    
    
    
}
