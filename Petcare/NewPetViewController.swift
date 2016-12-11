//
//  PetController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CoreData
import CZPicker
import DatePickerDialog
import WatchConnectivity

class PetController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CZPickerViewDelegate, CZPickerViewDataSource {
    
    let dao = CoreDataDAO<Pet>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pets = [["Cat": UIImage(named: "catIcon")], ["Dog": UIImage(named: "dogIcon")]]
    var sex: String = "Male"
    var date: Date?
    
    let czpicker = CZPickerView(headerTitle: "Species", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    
    var petToCreate: Pet!
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var breed: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var birthdayTextField: UITextField!
    

    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.delegate = self
        self.breed.delegate = self
        self.type.delegate = self
        self.birthdayTextField.delegate = self
        
        czpicker?.delegate = self
        czpicker?.dataSource = self
        
        czpicker?.allowMultipleSelection = false
        
        czpicker?.needFooterView = true
        
        self.type.allowsEditingTextAttributes = false
        
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch sexSegment.selectedSegmentIndex {
        case 0:
            self.sex = "Male"
        case 1:
            self.sex = "Female"
        default:
            break;
        }
        
    }
    
    func validatePet(pet: Pet) -> Bool{
        
        var petIsOk = true
        
        
        if (pet.name?.isEmpty)! {
            
            petIsOk = false
            self.name.backgroundColor = UIColor.red
            
        } else {
            
            self.name.backgroundColor = UIColor.white

        }
        
        if (pet.breed?.isEmpty)! {
            
            petIsOk = false
            self.breed.backgroundColor = UIColor.red
            
        } else {
            
            self.breed.backgroundColor = UIColor.white
            
        }
        
        if (pet.type?.isEmpty)! {
            
            petIsOk = false
            self.type.backgroundColor = UIColor.red

        } else {
            
            self.type.backgroundColor = UIColor.white
            
        }
        
        if (pet.sex?.isEmpty)! {
            
            petIsOk = false
            self.sexSegment.backgroundColor = UIColor.red
            
        } else {
            
            self.sexSegment.backgroundColor = UIColor.white
            
        }
        
        return petIsOk
        
    }
    
    func create(pet: Pet){
        
        if validatePet(pet: pet){
            
            dao.insert(pet)

        }
        
    }
    
    func delete(pet: Pet){
        
        dao.delete(pet)
    }
    
    func update(pet: Pet){
        
        var petToUpdate = getByID(id: pet.objectID)
        
        petToUpdate = pet
        
        dao.update(petToUpdate)
    }
    
    func getAll() -> [Pet] {
        
        return dao.getAll()
    }
    
    func getByID(id: NSManagedObjectID) -> Pet{
        
        return dao.getByID(id)
    }

    
    func buildPet() -> Pet{
        
        let imageData: NSData = UIImagePNGRepresentation(imagePicked.image!)! as NSData

        let pet = Pet(name: self.name.text!, birthdate: self.date! as NSDate as NSDate, breed: self.breed.text!, photo: imageData, sex: self.sex, type: self.type.text!, context: self.context)
        
        return pet
    }
    
    func savePet() {
        
        self.create(pet: petToCreate)
        
    }
    

    // MARK: - Get camera Image
    
    
    @IBAction func openLibraryButton(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        /*if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }*/
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil);
        
    }
    
    // MARK: - Segue

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        petToCreate = buildPet()
        
        var shouldSegue = false
        
        if identifier == "prefrerencesSegue" {
            
            shouldSegue =  validatePet(pet: petToCreate)
            
        }
        
        return shouldSegue
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        savePet()
        
        let dict = ["Name": self.petToCreate.name!, "Type": self.petToCreate.type!,
                    "Breed": self.petToCreate.breed!] as [String : Any]
                
        WCSession.default().transferUserInfo(["PetCreated": dict])
        let confirmPetController = segue.destination as! ConfirmPetViewController
        
        confirmPetController.pet = petToCreate
    }
    
    // MARK: - CZPicker

    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return pets.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return pets[row].keys.first
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return pets[row].values.first!
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        type.text = pets[row].keys.first
    }
    
    
    @IBAction func speciesFieldTouchDown(_ sender: UITextField) {
       // czpicker?.show()
        let options = [
            ["value": "Cat", "display": "Cat"],
            ["value": "Dog", "display": "Dog"]
        ]
        
        PickerDialog().show("Species", options: options) { (value) in
            
            self.type.text = value
        }
    }
   
    
    @IBAction func birthdayFieldTouchDown(_ sender: UITextField) {
        DatePickerDialog().show("Pet's birthday", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .date, callback: { (date) in
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            if let date = date {
                self.birthdayTextField.text = formatter.string(from: date)
                
                self.date = date
            }
            
            
        })
        
        sender.resignFirstResponder()
    }
    

}
