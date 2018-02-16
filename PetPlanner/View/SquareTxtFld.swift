//
//  SquareTxtFld.swift
//  PetPlanner
//
//  Created by Caroline Davis on 16/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class SquareTxtFld: UITextField {

    override func awakeFromNib() {
        
      
        //layer.cornerRadius = 30
        layer.shadowColor = BLACK_COLOR.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.0
        layer.shadowOffset = CGSize(width: 0.4, height: 0.8)
        
    }


}
