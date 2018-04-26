//
//  HealthInfoVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 5/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase

class HealthInfoVC: UIViewController, UITextFieldDelegate {
    
    var pet: PetProfile!
    var health: PetHealth!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var save: CurvedBtn!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var breedField: SquareTxtFld!
    @IBOutlet weak var weightField: SquareTxtFld!
    @IBOutlet weak var vaccinationsField: SquareTxtFld!
    @IBOutlet weak var allergiesField: SquareTxtFld!
    @IBOutlet weak var medicationsField: SquareTxtFld!
    @IBOutlet weak var spayedOrNeuteredField: SquareTxtFld!
    @IBOutlet weak var vetField: SquareTxtFld!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        breedField.delegate = self
        weightField.delegate = self
        vaccinationsField.delegate = self
        allergiesField.delegate = self
        medicationsField.delegate = self
        spayedOrNeuteredField.delegate = self
        vetField.delegate = self
        
        activityIndicator.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        DataService.ds.getPet(petId: CURRENT_PET_ID) { (petProfile) in
            self.pet = petProfile
        
            DataService.ds.getHealth(petId: CURRENT_PET_ID) { (petHealth) in
                self.health = petHealth
                
                if petHealth != nil {
                    DispatchQueue.main.async {
                        self.breedField.text = self.health.breed
                        self.weightField.text = self.health.weight
                        self.vaccinationsField.text = self.health.vaccinations
                        self.allergiesField.text = self.health.allergies
                        self.medicationsField.text = self.health.medications
                        self.spayedOrNeuteredField.text = self.health.spayedOrNeutered
                        self.vetField.text = self.health.vet
                    }
                }
          
     
        DispatchQueue.main.async {
            self.name.text = "\(self.pet.name.capitalized)'s Health"
            
                }
            }
        }
    }
    
    
       @IBAction func saveHealth(_ sender: Any) {
        
        saveBtnDisabled(save: save, activityIndicator: activityIndicator)
    
        let breed = breedField.text?.capitalized
        let weight = weightField.text?.capitalized
        let vaccinations = vaccinationsField.text?.capitalized
        let allergies = allergiesField.text?.capitalized
        let medications = medicationsField.text?.capitalized
        let spayedOrNeutered = spayedOrNeuteredField.text?.capitalized
        let vet = vetField.text?.capitalized
        
        

        // if there is no info yet...
        if self.health == nil {
            DataService.ds.createHealth(petId: CURRENT_PET_ID, userId: USER_ID, breed: breed!, weight: weight!, vaccinations: vaccinations!, allergies: allergies!, medications: medications!, spayedOrNeutered: spayedOrNeutered!, vet: vet!, completion: { (error) in
                if error != nil {
                    self.alerts(message: error!)
                    
                } else {
                    print("it worked")
                }
                saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
                })
        } else {
            DataService.ds.editHealth(petId: CURRENT_PET_ID, breed: breed!, weight: weight!, vaccinations: vaccinations!, allergies: allergies!, medications: medications!, spayedOrNeutered: spayedOrNeutered!, vet: vet!, completion:{ (error) in
                if error != nil {
                    self.alerts(message: error!)
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
