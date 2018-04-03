//
//  ViewPetsVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewPetsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    
    var tableViewData = [PetProfile]()
    
    // TO DO: If user has paid for the account they get all the pets in the tableview
    // IF they have not paid - they get 1 pet and the next cell should read "Upgrade to paid version to add multiple pets"
    // and have the lock picture as the profilePicture.
    // if they click that lock they go to the appstore blah to upgrade
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 105
        
       // tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        DataService.ds.getAllPets { (pets) in
            self.tableViewData = pets
            self.tableView.reloadData()
        }
        
        
    }
    
         
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count 
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as? PetCell {
            let pet = self.tableViewData[indexPath.row]
            
            cell.name?.text = pet.name.capitalized
            cell.dob?.text = "D.O.B: \(pet.dob.capitalized)"
            cell.species?.text = "SPECIES: \(pet.species.capitalized)"
            cell.sex?.text = "SEX: \(pet.sex.capitalized)"
            cell.idTag?.text = "I.D: \(pet.idTag.capitalized)"
            
            cell.deleteCell.tag = indexPath.row
            cell.deleteCell.addTarget(self, action: #selector(deletePet), for: .touchUpInside)
            
            cell.editCell.tag = indexPath.row
            cell.editCell.addTarget(self, action: #selector(editPet), for: .touchUpInside)
            
            cell.profilePic?.sd_setImage(with: URL(string: pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload])
            
 
          //  cell.updateUI(petCell: petCell)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("hi")
//
//        // add in the edit + delete swipey
//        // if edit go to create pet screen + update info in firebase
//        // if delete add a pop 'are you sure' then if they click yes then update info in firebase
//    }
    
   // button1.addTarget(self, action: "buttonClicked:", for: .touchUpInside)
   // button2.addTarget(self, action: "buttonClicked:", for: .touchUpInside)

    
    @objc func deletePet(sender: UIButton) {
        print(sender.tag)
        // this is the number of the pet in the array we wish to delete
        print("hello \(tableViewData.count)")
        let pet = self.tableViewData[sender.tag]
        let petId = pet.petId
        
        // removes from the ui
        tableViewData.remove(at: sender.tag)
        self.tableView.reloadData()
        
        // removes the data from firebase
        DataService.ds.DB_BASE.child("pets").child(petId).removeValue()
    
    }
    
    @objc func editPet(sender: UIButton) {
    }

 
}
