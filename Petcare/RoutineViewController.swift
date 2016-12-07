//
//  BathViewController.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // class atributes
    var pet: Pet?
    var routineType: Int!
    var routineArray = [Routine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch routineType {
        case 0:
            routineArray = pet?.bath!.array as! [Bath]
        case 1:
            routineArray = pet?.hair!.array as! [Hair]
        case 2:
            routineArray = pet?.teeth!.array as! [Teeth]
        case 3:
            routineArray = pet?.nails!.array as! [Nails]
        case 4:
            routineArray = pet?.recreation!.array as! [Recreation]
        case 5:
            routineArray = pet?.deworming!.array as! [Deworming]
        case 6:
            routineArray = pet?.vaccination!.array as! [Vaccination]
        default:
            print("error")
        }
        
    }
    
    @IBAction func add(_ sender: Any) {
        //        let dao = CoreDataDAO<Recreation>()
        //        let recreation = dao.new()
        //
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        //
        //        recreation.date = dateFormatter.date(from: self.dateTf.text!) as NSDate?
        //        recreation.pet = self.pet
        //
        //        // adding to pets array os baths
        //        let petBaths = pet?.recreation as! NSMutableOrderedSet
        //        petBaths.add(recreation)
        //
        //        dao.insert(recreation)
        //        recreationArray.append(recreation)
        //        tableView.reloadData()
        
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
