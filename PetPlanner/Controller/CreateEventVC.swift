//
//  CreateEventVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    
    @IBOutlet weak var name: SquareTxtFld!
    @IBOutlet weak var location: SquareTxtFld!
    
    var date: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func getDateAndTime(_ sender: UIDatePicker) {
        date = sender.date
    }
    
    @IBAction func save(_ sender: Any) {
        // do firebase function
    }
    
    
}
