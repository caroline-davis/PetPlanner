//
//  ViewPetsVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
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
            
            cell.profilePic?.sd_setImage(with: URL(string: pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload])
            
 
          //  cell.updateUI(petCell: petCell)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
        // go to pet profile page
        // add in the edit + delete swipey
        // if edit go to create pet screen + update info in firebase
        // if delete add a pop 'are you sure' then if they click yes then update info in firebase
    }
    

    

    
}
