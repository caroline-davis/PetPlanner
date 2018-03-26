//
//  CurvedLbl.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/3/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CurvedLbl: UILabel {
    
    var shadowLayer: CAShapeLayer!
    var cornerRadius: CGFloat = 15.0
    
    override func layoutSubviews() {
            super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = WHITE_COLOR.cgColor
            
            shadowLayer.shadowColor = BLACK_COLOR.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.8, height: 2.0)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 1.5
            

            layer.insertSublayer(shadowLayer, at: 0)
        }

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        layer.cornerRadius = 15
//    //    layer.shadowColor = BLACK_COLOR.cgColor
//   //     layer.shadowOpacity = 0.4
//     //   layer.shadowRadius = 1.5
//     //   layer.shadowOffset = CGSize(width: 0.8, height: 2.0)
//        layer.masksToBounds = true
    
    }
}

