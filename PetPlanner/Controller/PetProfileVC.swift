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
    var profileImage: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        //  _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataService.ds.getPet(petId: petId) { (petProfile) in
            self.pet = petProfile
            
            // profile pic string from firebase too
            // ternary operator
            // if this statement is true then do the first thingy, else do the second thingy
            let image = self.profileImage != nil ? self.profileImage : DEFAULT_PROFLE_IMAGE
            
            // downloads contents of the url and puts the data as a uiimage
            let url = URL(string: image!)
            let data = try? Data(contentsOf: url!)
            
            if let imageData = data {
                self.profilePic.image = UIImage(data: imageData)
            }
            
            self.name.text = self.pet.name.capitalized
            self.dob.text = self.pet.dob
        }
        
    }



}
