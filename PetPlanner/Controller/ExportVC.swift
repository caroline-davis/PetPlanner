//
//  ExportVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 18/10/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class ExportVC: UIViewController {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var exportView: UIView!
    @IBOutlet weak var info: UITextView!
    
    var petBasics = ["Sex" : "Male",
                     "DOB" : "11/10/1989",
                     "Spayed/Neutered" : "",
                     "ID" : "82398HG7"]
    var petFavs = ["Food" : "Tuna",
                   "Drink" : "Milk",
                   "Toy" : "",
                   "Sleeping Nook" : "Stairs"]
    var petHealth = ["Breed" : "Persian",
                     "Allergies" : "Hair",
                     "Vaccinated" : "",
                     "Vet" : ""]
    var petEvents = ["Name": "Nail Trim",
                     "Date" : "15/10/2018",
                     "Time": "5pm",
                     "Location" : "The Vet Man"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Assign a UIImage version of my UIView as a printing iten
        let newImage = self.exportView.toImage()
        
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
    func activities(facts: [String: String], combinedFacts: String) -> String {
        let results = facts.reduce(combinedFacts) { result, next  in
            if (next.value != "") {
                return (result + next.key + ": " + next.value + "\n")
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
              completion(true)
            }
        } else {
            print ("oops error land")
        }

    }
    
    
    
}
