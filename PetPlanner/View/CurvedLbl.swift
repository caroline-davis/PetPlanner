//
//  CurvedLbl.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/3/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CurvedLbl: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 15
        layer.borderColor = PINK_COLOR.cgColor
        layer.borderWidth = 3.0
        layer.masksToBounds = true
    
    }
}
