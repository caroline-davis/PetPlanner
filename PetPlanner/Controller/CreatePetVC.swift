//
//  CreatePetVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase

class CreatePetVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var speciesField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var idTagField: UITextField!
    
    @IBOutlet weak var save: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        dobField.delegate = self
        speciesField.delegate = self
        sexField.delegate = self
        idTagField.delegate = self
        
    }


    @IBAction func saveClicked() {
        guard case let name = nameField.text, name != "" else {
            self.alerts(message: "Please provide your pet's name")
            return
        }
        
        let dob = dobField.text
        let idTag = idTagField.text
        let species = speciesField.text
        let sex = sexField.text
        
        let profileImage = "fake image"
        
        DataService.ds.createPet(
            dob: dob!,
            idTag: idTag!,
            name: name!,
            profileImage: profileImage,
            sex: sex!,
            species: species!,
            completion: { (error, petId) in
        
                if error != nil {
                    self.alerts(message: error!)
                } else {
                    self.goToPetProfileVC(petId: petId)
                }
            })
    }
    
    func goToPetProfileVC(petId: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PetProfileVC") as! PetProfileVC
        vc.petId = petId
        self.present(vc, animated: false, completion: nil)
    }


}
