//
//  BathViewController.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class BathViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // class atributes
    var pet: Pet?
    var bathsArray = [Bath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bathsArray = pet?.bath!.array as! [Bath]
        
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
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        return cell
    }
}
