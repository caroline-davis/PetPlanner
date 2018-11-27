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
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         cornerCurves()
        
    }
    
    func cornerCurves() {
        if (self.tag == 0) {
            layer.cornerRadius = 4
            layer.shadowColor = BLACK_COLOR.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 2.0
            layer.shadowOffset = CGSize(width: 0.8, height: 2.0)
        } else if (self.tag == 1) {
            layer.cornerRadius = 0
        } else if (self.tag == 2) {
            layer.cornerRadius = 0
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
    }
}
