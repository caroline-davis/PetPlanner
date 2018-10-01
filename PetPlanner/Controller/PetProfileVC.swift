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
        
        CURRENT_PET_ID = petId
        
        // hides the standard back button
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        // sets the button to go back to the home screen
        let homeButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(homePage))
        self.navigationItem.leftBarButtonItem = homeButton
        
        // sets the button to export the pet info as pdf
        let pdfButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(exportPetInfo))
        
        pdfButton.image = UIImage(named: "exportButton")
        self.navigationItem.rightBarButtonItem = pdfButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
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
    
    @objc func homePage() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func exportPetInfo() {
        
        // TO DO: Export info for pet for a PDF format
        
        // code for the pdf export then below to send/save
        // self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func toEventsVC(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventsVC") as! EventsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    @IBAction func toHealthInfoVC(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HealthInfoVC") as! HealthInfoVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func toFavsListVC(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavsListVC") as! FavsListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    
}
