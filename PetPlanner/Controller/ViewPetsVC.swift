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
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableViewAutomaticDimension
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
            
            cell.name?.text = pet.name
            cell.dob?.text = pet.dob
            cell.species?.text = pet.species
            cell.sex?.text = pet.sex
            cell.idTag?.text = pet.idTag
            
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
