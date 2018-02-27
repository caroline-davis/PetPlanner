//
//  ViewPetsVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class ViewPetsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
     var tableViewData = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as? PetCell {
            let dictionary = self.tableViewData[indexPath.row]
         
            cell.title?.text = dictionary["petTitle"] as! String?
            cell.dob?.text = dictionary["petDob"] as! String?
            cell.species?.text = dictionary["petSpecies"] as! String?
            cell.sex?.text = dictionary["petSex"] as! String?
            cell.idTag?.text = dictionary["petIdTag"] as! String?
         //   cell.img?.text = dictionary["petImageUrl"] as! String?
            
            //   cell.updateUI(partyRock: partyRock)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
    }
    


}
