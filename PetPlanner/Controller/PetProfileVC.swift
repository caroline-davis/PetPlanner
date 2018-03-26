//
//  PetProfileVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 19/3/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class PetProfileVC: UIViewController  {
    
    @IBOutlet weak var profilePic: CircularImgView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var calendar: UIButton!
    @IBOutlet weak var health: UIButton!
    @IBOutlet weak var checklist: UIButton!
    
    var petId: String!
   
    var pet: PetProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        //  _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataService.ds.getPet(petId: petId) { (petProfile) in
            self.pet = petProfile
            
            DispatchQueue.main.async {
                self.name.text = self.pet.name.capitalized
                self.dob.text = self.pet.dob
            }

            // profile pic string from firebase too
       
            // downloads contents of the url and puts the data as a uiimage
            let url = URL(string: self.pet.profileImage)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                    self.profilePic.image = UIImage(data: imageData)
                
            }
        }
        
    }


}
