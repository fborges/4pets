//
//  PetDashboardViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 01/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CKCircleMenuView

class PetDashboardViewController: UIViewController, CKCircleMenuDelegate {
    
    // outlets
    @IBOutlet weak var petPhoto: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petBrithday: UILabel!
    @IBOutlet weak var petSexImageView: UIImageView!
    
    // internal variables
    var pet: Pet!
    private var circleMenuView: CKCircleMenuView!
    let circleMenuImageArray = [ #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath"), #imageLiteral(resourceName: "bath")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
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
        configurePopUpMenu()
        self.circleMenuView!.openMenu()
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
        performSegue(withIdentifier: "routineViewController", sender: anIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "routineViewController" {
            let index =  Int(exactly: sender as! Int32)
            let viewController = segue.destination as! RoutineViewController
            
            viewController.pet = self.pet
            viewController.routineType = index
            
        }
        
        
        
    }
    
    
    
    
}
