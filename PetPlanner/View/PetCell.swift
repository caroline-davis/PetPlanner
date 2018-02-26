//
//  PetCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    
    @IBOutlet weak var img: CircularImgView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var id: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
  
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

