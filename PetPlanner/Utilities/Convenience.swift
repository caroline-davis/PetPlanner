//
//  Convenience.swift
//  PetPlanner
//
//  Created by Caroline Davis on 19/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

extension UIViewController {
    
func alerts(message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    
    }
}



