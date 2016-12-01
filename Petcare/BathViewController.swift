//
//  BathViewController.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class BathViewController<T>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // class atributes
    var pet: Pet?
    var bathsArray = [T]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bathsArray = pet?.bath!.array as! [T]
        
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
        return bathsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBath", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dao = CoreDataDAO<Bath>()
            let bath = bathsArray[indexPath.row]
            
            //dao.delete(bath)
            bathsArray.remove(at: indexPath.row)
            //pet?.bath.a
            tableView.reloadData()
        }
    }
}
