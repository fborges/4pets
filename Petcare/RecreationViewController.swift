//
//  RecreationViewController.swift
//  Petcare
//
//  Created by Raul Marques de Oliveira on 30/11/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class RecreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    // class atributes
    var pet: Pet?
    var recreationArray = [Recreation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recreationArray = pet?.recreation!.array as! [Recreation]
        
    }

    

    // MARK: - TableView methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recreationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellRecreation", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        return cell
    }


}
