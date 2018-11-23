//
//  DatePicker.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/9/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class DatePicker: UIDatePicker {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setValue(UIColor.white, forKeyPath: "textColor")
    }
}
