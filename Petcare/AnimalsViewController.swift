//
//  AnimalsViewController.swift
//  Petcare
//
//  Created by Felipe Borges on 28/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit
import WatchConnectivity

class AnimalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WCSessionDelegate {
    
    var session: WCSession!

    
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
        loadPetList()
    }
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dao = CoreDataDAO<Pet>()
            let pet = petList[indexPath.row]
            
            dao.delete(pet)
            petList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dashboard" {
            let indexPath = sender as! IndexPath
            let viewController = segue.destination as! PetDashboardViewController
            
            viewController.pet = petList[indexPath.row]
        }
    }
    
    
    // MARK: - Connectivity Methods
    
    func sendMessageToWatch() {
        petList = dao.getAll()
        session.sendMessage(["petList":petList], replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {

        if (message["sendPetList"]! as? Bool)! {
            
            sendMessageToWatch()
        }
    }
    

    /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
}
