//
//  FavsListVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class FavsListVC: UIViewController {

    
    
    @IBOutlet weak var foodField: SquareTxtFld!
    @IBOutlet weak var drinkField: SquareTxtFld!
    @IBOutlet weak var toyField: SquareTxtFld!
    @IBOutlet weak var sleepingNookField: SquareTxtFld!
    @IBOutlet weak var activityField: SquareTxtFld!
    @IBOutlet weak var hidingSpotField: SquareTxtFld!
    @IBOutlet weak var feastingTimeField: SquareTxtFld!
    @IBOutlet weak var OtherField: SquareTxtFld!
    
    
    @IBOutlet weak var save: CurvedBtn!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
    
    
    @IBAction func saveFavs(_ sender: Any) {
    }
    
  

}
