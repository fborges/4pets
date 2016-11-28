//
//  PetController.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import CoreData

class PetController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let dao = CoreDataDAO<Pet>()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var imagePicked: UIImageView!
    
    override func viewDidLoad() {
        
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
    
    func create(pet: Pet){
        
        dao.insert(pet)
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
    
    // MARK: - Get camera Image
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil);
        
    }
    
    @IBAction func saveButt(sender: AnyObject) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let alert = UIAlertView(title: "Wow",
                                message: "Your image has been saved to Photo Library!",
                                delegate: nil,
                                cancelButtonTitle: "Ok")
        alert.show()
    }
}
