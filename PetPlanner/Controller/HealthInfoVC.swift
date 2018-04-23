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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        DispatchQueue.main.async {
            self.name.text = "\(self.pet.name.capitalized)'s Health"
        }
    }
    
    
    @IBAction func saveHealth(_ sender: Any) {
        
        let breed = breedField.text
        let weight = weightField.text
        let vaccinations = vaccinationsField.text
        let allergies = allergiesField.text
        let medications = medicationsField.text
        let spayedOrNeutered = spayedOrNeuteredField.text
        let vet = vetField.text
        
    
        
    }
    
    // when enter is pressed keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }





}
