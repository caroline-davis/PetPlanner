//
//  ImgAndTxtBtn.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class ImgAndTxtBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView?.contentMode = .scaleAspectFit
    
       

      // aligns button to the left instead of centre
        self.contentHorizontalAlignment = .left
        // have also added insets to the button on storyboard
        cornerCurves()
    }
    
    func cornerCurves() {

        if (self.viewWithTag(1) == nil) {
            layer.cornerRadius = 4
            layer.shadowColor = BLACK_COLOR.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 2.0
            layer.shadowOffset = CGSize(width: 0.8, height: 2.0)
            
        } else {
     layer.cornerRadius = 0
        }
    }
    
 
    
}
