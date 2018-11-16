//
//  CircularBtn.swift
//  PetPlanner
//
//  Created by Caroline Davis on 16/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CircularBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.contentMode = .scaleAspectFit
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // makes the button 100% round
        layer.cornerRadius = self.frame.width / 2
        
        border()
    
    }
    
    func border() {
        if (self.viewWithTag(1) == nil) {
            layer.borderWidth = 2
            layer.borderColor = WHITE_COLOR.cgColor
        }
    }

}

