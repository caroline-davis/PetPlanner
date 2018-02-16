//
//  SquareBtn.swift
//  PetPlanner
//
//  Created by Caroline Davis on 16/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class SquareBtn: UIButton {

    override func awakeFromNib() {
        
        layer.cornerRadius = 4
        layer.shadowColor = BLACK_COLOR.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSize(width: 0.8, height: 2.0)
    }

}
