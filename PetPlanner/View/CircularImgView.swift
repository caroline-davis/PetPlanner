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
            borderWidth()
        
            layer.cornerRadius = frame.size.width / 2
             layer.masksToBounds = true
        

    }
    
    func colourSwap() {
        if (self.viewWithTag(1) != nil) {
            layer.borderColor = PINK_COLOR.cgColor
        } else {
            layer.borderColor = WHITE_COLOR.cgColor
        }
    }
    
    func borderWidth() {
        if (self.viewWithTag(3) != nil) {
            layer.borderWidth = 3
        } else {
            layer.borderWidth = 6
        }
    }
 
    

}
