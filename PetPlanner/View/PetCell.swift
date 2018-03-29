//
//  PetCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    

    @IBOutlet weak var profilePic: CircularImgView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var idTag: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

