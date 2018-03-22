//
//  PetProfileVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 19/3/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class PetProfileVC: UIViewController {
    
    var petId: String!
    var pet: PetProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        //  _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataService.ds.getPet(petId: petId) { (petProfile) in
            self.pet = petProfile
        }
        
    }




}
