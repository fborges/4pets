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

class PetController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, CZPickerViewDelegate, CZPickerViewDataSource {
    
    let dao = CoreDataDAO<Pet>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pets = [["Cat": UIImage(named: "catIcon")], ["Dog": UIImage(named: "dogIcon")]]
    var sex: String = "Male"
    
    
    let czpicker = CZPickerView(headerTitle: "Species", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
    
   
    
    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var breed: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    
    
    @IBOutlet weak var sexSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        
        self.name.delegate = self
        self.breed.delegate = self
        self.type.delegate = self
        
        czpicker?.delegate = self
        czpicker?.dataSource = self
        
        czpicker?.allowMultipleSelection = false
        
        czpicker?.needFooterView = true
        
        
//        let pet = Pet(name: "Wesley", birthdate: NSDate(), breed: "Safadão", photo: NSData(), sex: "Masculino", type: "Raparigueiro", context: self.context)
//        self.create(pet: pet)
//        
//        let pets = getAll()
//        
//        print(pets[0].name!)
//        
//        let petToUpdate = getByID(id: pets[0].objectID)
//        
//        petToUpdate.name = "Senhor Wesley"
//        
//        let petAfterUpdate = getAll()
//        
//        print(petAfterUpdate[0].name!)
//        
//        
//        let petToDelete = getByID(id: petAfterUpdate[0].objectID)
//        print(petToDelete.name!)
//        self.delete(pet: petToDelete)
//        
//        let newPets = getAll()
//        print(newPets[0].name!)
        
        
    }
    
    func validatePet(pet: Pet) -> Bool{
        
        var petIsOk = true
        
        
        if (pet.name?.isEmpty)! {
            
            petIsOk = false
            self.name.backgroundColor = UIColor.red
            
        }
        
        if (pet.breed?.isEmpty)! {
            
            petIsOk = false
            self.name.backgroundColor = UIColor.red
            
        }
        
        if (pet.type?.isEmpty)! {
            
            petIsOk = false
            self.name.backgroundColor = UIColor.red

        }
        
        if (pet.sex?.isEmpty)! {
            
            petIsOk = false
            self.name.backgroundColor = UIColor.red
            
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

    
    func savePet() -> Pet {
        
        let imageData: NSData = UIImagePNGRepresentation(imagePicked.image!)! as NSData
        
        let pet = Pet(name: self.name.text!, birthdate: NSDate() as NSDate, breed: self.breed.text!, photo: imageData, sex: self.sex, type: self.type.text!, context: self.context)
        
        self.create(pet: pet)
        
        return pet
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
    
    
    // MARK: - Get camera Image
    
    
    @IBAction func openLibraryButton(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
//    @IBAction func openCameraButton(sender: AnyObject) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
//    
//    
//    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
//            imagePicker.allowsEditing = true
//            self.present(imagePicker, animated: true, completion: nil)
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let pet = savePet()
        
        let confirmPetController = segue.destination as! ConfirmPetViewController
        
        confirmPetController.pet = pet
    }
    
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
        czpicker?.show()
        
    }
   
    
    @IBAction func birthdayFieldTouchDown(_ sender: UITextField) {
        DatePickerDialog().show("Pet's birthday", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: Date(), datePickerMode: .date, callback: { (date) in
            print(date)
        })
        
        sender.resignFirstResponder()
    }
    

}
