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
        
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        name.textColor = WHITE_COLOR
        species.textColor = WHITE_COLOR
        dob.textColor = WHITE_COLOR
        sex.textColor = WHITE_COLOR
        idTag.textColor = WHITE_COLOR
        
       
    }
    

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}

