//
//  CurvedBtn.swift
//  PetPlanner
//
//  Created by Caroline Davis on 16/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CurvedBtn: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.size.height / 2.0
        layer.shadowColor = BLACK_COLOR.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0.8, height: 2.0)
    }
}
