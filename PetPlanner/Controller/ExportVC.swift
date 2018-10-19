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
    
    var petBasics = ["Sex": "Male",
                     "DOB": "11/10/1989",
                     "Spayed/Neutered": "",
                     "ID": "82398HG7"]
    var petFavs = ["Food": "Tuna",
                   "Drink": "Milk",
                   "Toy": "",
                   "sleepingNook": "Stairs"]
    var petHealth = ["breed": "Persian",
                     "allergies": "Hair",
                     "Vaccinated": "",
                     "Vet": "vet guy"]
    var petEvents = ["name": "Nail Trim",
                     "Date": "15/10/2018",
                     "Time": "5pm",
                     "Location": "The Vet Man"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        CURRENT_PET_ID = petId
        
        let petDictionaries: [[String: String]] = [
            petBasics,
            petFavs,
            petHealth
        ]
        
        petInfo(allFacts: petDictionaries, completion: { success  in
            if success {
                self.exportPetProfile()
            }
        })
    }
    
    func exportPetProfile() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Assign a UIImage version of my UIView as a printing iten
        let newImage = self.exportView.toImage()
       
        let activityViewController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
    
            if success || error == nil {
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                
                print("Carol: success")
       
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
                    print("CAROL:\(formattedKey)next key:\(next.key)")
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
            DispatchQueue.main.async {
              self.info.text = results
                
                // put the image and name bit here.
                
              completion(true)
            }
        } else {
            print ("oops error land")
        }

    }
    
    
    
}

//func exportPetProfile() {
//
//    // Assign a UIImage version of my UIView as a printing iten
//    let newImage = self.exportView.toImage()
//
//    let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
//    activityViewController.popoverPresentationController?.sourceView = self.view
//    present(activityViewController, animated: true, completion: nil)
//}
//    
