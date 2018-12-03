//
//  ExportVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 18/10/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ExportVC: UIViewController {
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var petId: String!
    var pet: PetProfile!
    
    var basics = [String: String]()
    var health = [String: String]()
    var favs = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CURRENT_PET_ID = petId
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // gets info from firebase and puts it into the petdictionaries
        DataService.ds.getPet(petId: CURRENT_PET_ID) { (petProfile) in
            self.basics = petProfile?.toDict() ?? ["empty": "empty"]
            
            DataService.ds.getHealth(petId: CURRENT_PET_ID) { (petHealth) in
                self.health = petHealth?.toDict() ?? ["empty": "empty"]
                
                DataService.ds.getFavs(petId: CURRENT_PET_ID) { (petFavs) in
                    self.favs = petFavs?.toDict() ?? ["empty": "empty"]
                    
                    let petDictionaries: [[String: String]] = [
                        self.basics,
                        self.health,
                        self.favs
                    ]
                    
                    self.petInfo(allFacts: petDictionaries, completion: { success  in
                        if success {
                            self.exportPetProfile()
                        } else {
                            self.alerts(title: "Error", message: "The export could not be completed at this time.")
                        }
                    })
                }
            }
        }
        
    }
    

    func exportPetProfile() {
        
        
        // Assign a UIImage version of my UIView as a printing iten
        let newImage = self.exportView.toImage()
        
        let activityViewController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            
            if success || error == nil {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            else if (error != nil){
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.alerts(title: "Error", message: "This was unable to be completed at this time.")
            }
            // once tasks are done, the view will go back to the pets profile screen
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func activities(facts: [String: String], combinedFacts: String) -> String {
        let results = facts.reduce(combinedFacts) { result, next  in
            
            if (next.value != "") {
                // if the firebase key is in the constant dictionary, display the value
                if let formattedKey = lookup[next.key] {
                    return (result + formattedKey + ": " + next.value + "\n")
                }
            }
            return result
        }
        return results + "\n"
    }
    
    
    // add a completion handler to know when to pop up export screen
    func petInfo(allFacts: [[String: String]], completion: @escaping (_ success: Bool) -> Void) {
        
        let results = allFacts.reduce("") { result, next  in
            return activities(facts: next, combinedFacts: result)
        }
        if results != "" {
            DataService.ds.getPet(petId: petId) { (petProfile) in
                self.pet = petProfile
                
                // gets image from firebase using sdwebimage
                self.profilePic.sd_setImage(with: URL(string: self.pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { profilePic, error, cacheType, URL in
                    
                })
                // displayed the image and pet name on the exporter
                DispatchQueue.main.async {
                    self.info.text = results
                    self.petName.text = self.pet.name.capitalized
                    
                    completion(true)
                }
            }
        }
        
    }
    
}

