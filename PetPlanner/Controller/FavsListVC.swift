//
//  FavsListVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class FavsListVC: UIViewController, UITextFieldDelegate {
    
    var pet: PetProfile!
    var favs: PetFavs!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var save: CurvedBtn!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
      @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
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
        
        // to get the pet name to appear
        DataService.ds.getPet(petId: CURRENT_PET_ID) { (petProfile) in
            self.pet = petProfile
            self.loadingActivityIndicator.isHidden = false
            self.loadingActivityIndicator.startAnimating()
            
            // to get the pet favs data to appear
            DataService.ds.getFavs(petId: CURRENT_PET_ID) { (petFavs) in
                self.favs = petFavs
                
                if petFavs != nil {
                    DispatchQueue.main.async {
                        self.foodField.text = self.favs.food
                        self.drinkField.text = self.favs.drink
                        self.toyField.text = self.favs.toy
                        self.sleepingNookField.text = self.favs.sleepingNook
                        self.activityField.text = self.favs.activity
                        self.hidingSpotField.text = self.favs.hidingSpot
                        self.feastingTimeField.text = self.favs.feastingTime
                        self.otherField.text = self.favs.other
                    }
                    self.loadingActivityIndicator.isHidden = true
                    self.loadingActivityIndicator.stopAnimating()
                }
                self.loadingActivityIndicator.isHidden = true
                self.loadingActivityIndicator.stopAnimating()
                
                DispatchQueue.main.async {
                    self.name.text = "\(self.pet.name.capitalized)'s Favourites"
                    
                }
            }
        }
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func saveFavs(_ sender: Any) {
        saveBtnDisabled(save: save, activityIndicator: activityIndicator)
        
        let food = foodField.text?.capitalized
        let drink = drinkField.text?.capitalized
        let toy = toyField.text?.capitalized
        let sleepingNook = sleepingNookField.text?.capitalized
        let activity = activityField.text?.capitalized
        let hidingSpot = hidingSpotField.text?.capitalized
        let feastingTime = feastingTimeField.text?.capitalized
        let other = otherField.text?.capitalized
        
        
        
        // if there is no info yet...
        if self.favs == nil {
            DataService.ds.createFavs(petId: CURRENT_PET_ID, userId: USER_ID, food: food!, drink: drink!, toy: toy!, sleepingNook: sleepingNook!, activity: activity!, hidingSpot: hidingSpot!, feastingTime: feastingTime!, other: other!, completion: { (error) in
                if error != nil {
                    self.alerts(title: "Error", message: error!)
                    
                } else {
                    print("it worked")
                }
                saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
            })
        } else {
            DataService.ds.editFavs(petId: CURRENT_PET_ID, food: food!, drink: drink!, toy: toy!, sleepingNook: sleepingNook!, activity: activity!, hidingSpot: hidingSpot!, feastingTime: feastingTime!, other: other!, completion:{ (error) in
                if error != nil {
                    self.alerts(title: "Error", message: error!)
                } else {
                    print("it worked")
                }
                saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
            })
        }
        
        
    }
    
    
    
  
    // when enter is pressed keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  


}
