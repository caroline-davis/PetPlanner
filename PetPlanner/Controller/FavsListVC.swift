//
//  FavsListVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase

class FavsListVC: UIViewController, UITextFieldDelegate {
    
    var pet: PetProfile!
    var favs: PetFavs!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var save: CurvedBtn!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var foodField: SquareTxtFld!
    @IBOutlet weak var drinkField: SquareTxtFld!
    @IBOutlet weak var toyField: SquareTxtFld!
    @IBOutlet weak var sleepingNookField: SquareTxtFld!
    @IBOutlet weak var activityField: SquareTxtFld!
    @IBOutlet weak var hidingSpotField: SquareTxtFld!
    @IBOutlet weak var feastingTimeField: SquareTxtFld!
    @IBOutlet weak var otherField: SquareTxtFld!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodField.delegate = self
        drinkField.delegate = self
        toyField.delegate = self
        sleepingNookField.delegate = self
        activityField.delegate = self
        hidingSpotField.delegate = self
        feastingTimeField.delegate = self
        otherField.delegate = self

       activityIndicator.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
    }
    
    
    
    @IBAction func saveFavs(_ sender: Any) {
        
        
    }
    
  

}
