//
//  ExportPetVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/10/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class ExportPetVC: UIViewController {
    
    // prac code
    var petBasics = ["Sex" : "Male", "DOB" : "11/10/1989", "Spayed/Neutered" : "", "colour": "black", "ID" : "82398HG7"]
    var petFavs = ["Food" : "Tuna", "Drink" : "Milk", "Toy" : "", "Sleeping Nook" : "Stairs"]
    var petHealth = ["Breed" : "Persian","Allergies" : "Hair", "Vaccinated" : "", "Vet" : ""]
    
    

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var info: UITextView!
    @IBOutlet weak var exportView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hides the standard back button
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        
        info.isEditable = false
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        let petDictionaries: [[String: String]] = [
            petBasics,
            petFavs,
            petHealth
        ]
        
        petInfo(allFacts: petDictionaries)
      
      // info.text = newPetInfo
    }
    

    func exportPetProfile() {
        
        // Assign a UIImage version of my UIView as a printing iten
        let newImage = self.exportView.toImage()
        
        let activityViewController = UIActivityViewController(activityItems: [newImage], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
                self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
                self.alerts(title: "Error", message: "This was unable to be completed at this time.")
            }
        }
        
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
    
    func petInfo(allFacts: [[String: String]]) -> String {
        let results = allFacts.reduce("") { result, next  in
            return activities(facts: next, combinedFacts: result)
        }
        info.text = results
        return results
    }
    
    
    
    
//    func firstTask(completion: (_ success: Bool) -> Void) {
//        // Do something
//
//        // Call completion, when finished, success or faliure
//        completion(true)
//    }
//
//  //  And use your completion block like this:
//
//    firstTask { (success) -> Void in
//    if success {
//    // do second task if success
//    secondTask()
//    }

    


}
