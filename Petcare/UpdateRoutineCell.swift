//
//  UpdateRoutineCell.swift
//  Petcare
//
//  Created by Gustavo Gomes de Oliveira on 15/12/16.
//  Copyright © 2016 Felipe Borges. All rights reserved.
//

import UIKit

class UpdateRoutineCell: UITableViewCell {
    
    
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineHour: UIButton!
    @IBOutlet weak var routineAmPm: UILabel!
    @IBOutlet weak var routineFrequency: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
