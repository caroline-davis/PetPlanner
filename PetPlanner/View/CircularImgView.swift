//
//  CircularImgView.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CircularImgView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()

            layer.cornerRadius = self.frame.width / 2
            layer.borderWidth = 5
            layer.borderColor = BLUE_COLOR.cgColor
            layer.masksToBounds = true
        
    }

}
