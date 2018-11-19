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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var counter = 0
    
    
    var tableViewData = [PetProfile]()
    
    // TO DO: If user has paid for the account they get all the pets in the tableview
    // IF they have not paid - they get 1 pet and the next cell should read "Upgrade to paid version to add multiple pets"
    // and have the lock picture as the profilePicture.
    // if they click that lock they go to the appstore blah to upgrade
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 100
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DataService.ds.getAllPets { (pets) in
            if pets == nil && self.counter == 0 {
                self.noPets()
            } else if pets == nil && self.counter != 0 {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.tableViewData = pets!
                self.tableView.reloadData()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func noPets() {
        
        counter += 1
        let alert = UIAlertController(title: "Error", message: "You have no pets! Please add a pet", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePetVC") as! CreatePetVC
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PetCell", for: indexPath) as? PetCell {
            let pet = self.tableViewData[indexPath.row]
            cell.tag = indexPath.row
            
            
            cell.configure(pet: pet)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pet = self.tableViewData[indexPath.row]
        let petId = pet.petId
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PetProfileVC") as! PetProfileVC
        vc.petId = petId
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let pet = self.tableViewData[indexPath.row]
        let petId = pet.petId
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("delete tapped")
            
            self.tableViewData.remove(at: indexPath.row)
            self.tableView.reloadData()
            
            // removes the data from firebase
            DataService.ds.DB_BASE.child("pets").child(petId).removeValue()
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            print("edit tapped")
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePetVC") as! CreatePetVC
            vc.petId = petId
            self.navigationController?.pushViewController(vc, animated: false)
        }
        edit.backgroundColor = .orange
        return [delete, edit]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = PINK_COLOR
            print(indexPath.row)
        } else {
            cell.backgroundColor = BLUE_COLOR
            print(indexPath.row)
        }
    }
}




//
//DataService.ds.getAllPets { (pets) in
//    if pets == nil && self.counter == 0 {
//        self.noPets()
//    } else {
//        self.tableViewData = pets!
//        self.tableView.reloadData()
//        self.activityIndicator.isHidden = true
//        self.activityIndicator.stopAnimating()
//    }
//}
//}
