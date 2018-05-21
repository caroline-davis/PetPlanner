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
        
            colourSwap()
            layer.cornerRadius = self.frame.width / 2
            layer.borderWidth = 6
            layer.masksToBounds = true

    }
    
    func colourSwap() {
        if (self.viewWithTag(1) != nil) {
            layer.borderColor = WHITE_COLOR.cgColor
        } else {
            layer.borderColor = BLUE_COLOR.cgColor
        }
    }
    

}
