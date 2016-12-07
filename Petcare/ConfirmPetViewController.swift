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

class ConfirmPetViewController: UIViewController, CZPickerViewDelegate, CZPickerViewDataSource {
    
    // outlets
    @IBOutlet weak var bathHourBtn: UIButton!
    @IBOutlet weak var hairHourBtn: UIButton!
    @IBOutlet weak var nailsHourBtn: UIButton!
    @IBOutlet weak var vaccinationHourBtn: UIButton!
    @IBOutlet weak var teethHourBtn: UIButton!
    @IBOutlet weak var dewormingHourBtn: UIButton!
    @IBOutlet weak var recreationHourBtn: UIButton!

    @IBOutlet weak var bathFrequencyBtn: UIButton!
    @IBOutlet weak var hairFrequencyBtn: UIButton!
    @IBOutlet weak var nailsFrequencyBtn: UIButton!
    @IBOutlet weak var vaccinationFrequencyBtn: UIButton!
    @IBOutlet weak var teethFrequencyBtn: UIButton!
    @IBOutlet weak var dewormingFrequencyBtn: UIButton!
    @IBOutlet weak var recreationFrequencyBtn: UIButton!
    
    
    // local atributes
    let frequency = ["Daily", "3 times a week", "5 times a week", "Weekly", "Monthly", "Yearly"]
    var pet: Pet!
    let czpicker = CZPickerView(headerTitle: "Frequency", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    var buttonSender: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // picker settings
        czpicker?.delegate = self
        czpicker?.dataSource = self
        czpicker?.allowMultipleSelection = false
        czpicker?.needFooterView = true
        
        addButtonActions()

    }
    
    func addButtonActions() {
        // frequency buttons
        bathFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        hairFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        nailsFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        vaccinationFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        teethFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        dewormingFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        recreationFrequencyBtn.addTarget(self, action: #selector(pickFrequency(sender:)), for: .touchUpInside)
        
        // hour buttons
        bathHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        hairHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        nailsHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        vaccinationHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        teethHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        dewormingHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
        recreationHourBtn.addTarget(self, action: #selector(pickHour(sender:)), for: .touchUpInside)
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
                
                var hour = Int(((self.bathHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
                var minute = Int(((self.bathHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
                print("\(hour):\(minute)")
            }
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        saveOnDAO()
    }
    
    func dateForFequency(hour: Int, minute: Int, frequency: String) -> Date {
        var dateComponent = DateComponents()
        let calendar = Calendar.autoupdatingCurrent
        var finalDate: Date!
        let todayDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())

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
   
        dateComponent.hour = hour
        dateComponent.minute = minute
        finalDate = calendar.date(byAdding: dateComponent, to: todayDate!)
        
        print(finalDate)
        return finalDate
    }
    
    func saveOnDAO() {

        var hour: Int!
        var minute: Int!
        
        //bath
        let daoBath = CoreDataDAO<Bath>()
        let bath = daoBath.new()
    
        hour = Int(((bathHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((bathHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)

        bath.date = dateForFequency(hour: hour!, minute: minute!, frequency: bathFrequencyBtn.title(for: .normal)!) as NSDate?
        bath.pet = self.pet

        // adding to pets array os baths
        let petBaths = pet?.bath as! NSMutableOrderedSet
        petBaths.add(bath)
        
        daoBath.insert(bath)
        
        // Hair
        let daoHair = CoreDataDAO<Hair>()
        let hair = daoHair.new()
        
        hour = Int(((hairHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((hairHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        hair.date = dateForFequency(hour: hour!, minute: minute!, frequency: hairFrequencyBtn.title(for: .normal)!) as NSDate?
        hair.pet = self.pet
        
        // adding to pets array os baths
        let petHair = pet?.hair as! NSMutableOrderedSet
        petHair.add(hair)
        
        daoHair.insert(hair)
        
        //Teeth
        let daoTeeth = CoreDataDAO<Teeth>()
        let teeth = daoTeeth.new()
        
        hour = Int(((teethHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((teethHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        teeth.date = dateForFequency(hour: hour!, minute: minute!, frequency: teethFrequencyBtn.title(for: .normal)!) as NSDate?
        teeth.pet = self.pet
        
        // adding to pets array os baths
        let petTeeth = pet?.teeth as! NSMutableOrderedSet
        petTeeth.add(teeth)
        
        daoTeeth.insert(teeth)
        
        //Nails
        let daoNails = CoreDataDAO<Nails>()
        let nails = daoNails.new()
        
        hour = Int(((nailsHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((nailsHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        nails.date = dateForFequency(hour: hour!, minute: minute!, frequency: nailsFrequencyBtn.title(for: .normal)!) as NSDate?
        nails.pet = self.pet
        
        // adding to pets array os baths
        let petNails = pet?.nails as! NSMutableOrderedSet
        petNails.add(nails)
        
        daoNails.insert(nails)
        
        //Vaccination
        let daoVaccination = CoreDataDAO<Vaccination>()
        let vaccination = daoVaccination.new()
        
        hour = Int(((vaccinationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((vaccinationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        vaccination.date = dateForFequency(hour: hour!, minute: minute!, frequency: vaccinationFrequencyBtn.title(for: .normal)!) as NSDate?
        vaccination.pet = self.pet
        
        // adding to pets array os baths
        let petVaccination = pet?.vaccination as! NSMutableOrderedSet
        petVaccination.add(vaccination)
        
        daoVaccination.insert(vaccination)
        
        //Deworming
        let daoDeworming = CoreDataDAO<Deworming>()
        let deworming = daoDeworming.new()
        
        hour = Int(((dewormingHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((dewormingHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        deworming.date = dateForFequency(hour: hour!, minute: minute!, frequency: dewormingFrequencyBtn.title(for: .normal)!) as NSDate?
        deworming.pet = self.pet
        
        // adding to pets array os baths
        let petDeworming = pet?.deworming as! NSMutableOrderedSet
        petDeworming.add(deworming)
        
        daoDeworming.insert(deworming)
        
        //Recreation
        let daoRecreation = CoreDataDAO<Recreation>()
        let recreation = daoRecreation.new()
        
        hour = Int(((recreationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[0])!)
        minute = Int(((recreationHourBtn.title(for: .normal)?.components(separatedBy: ":"))?[1])!)
        
        recreation.date = dateForFequency(hour: hour!, minute: minute!, frequency: recreationFrequencyBtn.title(for: .normal)!) as NSDate?
        recreation.pet = self.pet
        
        // adding to pets array os baths
        let petRecreation = pet?.recreation as! NSMutableOrderedSet
        petRecreation.add(recreation)
        
        daoRecreation.insert(recreation)
    }
    
    // MAERK : CZPicker
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return frequency.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return frequency[row]
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
         buttonSender.setTitle(frequency[row], for: .normal)
    }
}
