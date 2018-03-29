//
//  PetProfileVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 19/3/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import SDWebImage

class PetProfileVC: UIViewController  {
    
    @IBOutlet weak var profilePic: CircularImgView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        DataService.ds.getPet(petId: petId) { (petProfile) in
            self.pet = petProfile
            
            // gets image from firebase using sdwebimage
            self.profilePic.sd_setImage(with: URL(string: self.pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { (profilePic, error, cacheType, URL) in
                
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            })
            
            DispatchQueue.main.async {
                self.name.text = self.pet.name.capitalized
                self.dob.text = self.pet.dob
            }

        }
        
    }
    
    
}
