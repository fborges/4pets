//
//  AnimalsViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class AnimalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let dao = CoreDataDAO<Pet>()
    var petList: [Pet] = []
    
    @IBOutlet weak var talbeViewAnimals: UITableView!
    
    
    func loadPetList(){
        
        petList = dao.getAll()
        
        if petList.isEmpty{
            
            petList = []
        }
        
        DispatchQueue.main.async{
            self.talbeViewAnimals.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPetList()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        petList = dao.getAll()
        self.talbeViewAnimals.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = petList[indexPath.row].photo as! Data
        
        let image : UIImage = UIImage(data: data)!

        
        let cell:AnimalTableViewCell = self.talbeViewAnimals.dequeueReusableCell(withIdentifier: "animalCell") as! AnimalTableViewCell
        
        cell.petImageView.image = image
        cell.nameLabel.text = petList[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "dashboard", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboard" {
            let indexPath = sender as! IndexPath
            let viewController = segue.destination as! PetDashboardViewController
            
            viewController.pet = petList[indexPath.row]
        }
    }

}
