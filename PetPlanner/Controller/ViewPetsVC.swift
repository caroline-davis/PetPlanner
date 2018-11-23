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
    
    @IBOutlet weak var addPet: ImgAndTxtBtn!
    @IBOutlet weak var paidVersion: ImgAndTxtBtn!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var paid = false
    
    var tableViewData = [PetProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // TO DO: need to do a check - prob a call to apple to see if user has paid or not to set the paidversion bool to true or false
        
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.rowHeight = 100
            
            self.addPet.isHidden = true
            self.addPet.isEnabled = false
            self.paidVersion.isHidden = true
            self.paidVersion.isEnabled = false
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DataService.ds.getAllPets { (pets) in
            if pets != nil && self.paid == true {
                self.addPet.isHidden = true
                self.addPet.isEnabled = false
                self.paidVersion.isHidden = true
                self.paidVersion.isEnabled = false
                self.tableViewData = pets!
                self.tableView.reloadData()
            } else if pets == nil && self.paid == true {
                self.addPet.isHidden = false
                self.addPet.isEnabled = true
                self.paidVersion.isHidden = true
                self.paidVersion.isEnabled = false
            } else if pets != nil && self.paid == false {
                self.paidVersion.tag = 2
                print("HELLO: \(self.paidVersion.tag)")
                self.addPet.isHidden = true
                self.addPet.isEnabled = false
                self.paidVersion.isHidden = false
                self.paidVersion.isEnabled = true
                self.tableViewData = pets!
                self.tableView.reloadData()
            } else {
                self.addPet.isHidden = false
                self.addPet.isEnabled = true
                self.paidVersion.isHidden = false
                self.paidVersion.isEnabled = true
            }
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
        }
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
        
    //    TO DO: If after deleting a pet the pets are at nil. do the pop up to make a pet again.
        
        let pet = self.tableViewData[indexPath.row]
        let petId = pet.petId
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("delete tapped")
            
            self.tableViewData.remove(at: indexPath.row)
            self.tableView.reloadData()
            
            // if after deletion there are 0 pets, call the no pets func and segue to create a pet
            if self.tableViewData.count == 0 {
                self.addPet.isHidden = false
                self.addPet.isEnabled = true
            }
            
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
    
    @IBAction func addPet(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePetVC") as! CreatePetVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
    }
    
    @IBAction func upgradeApp(_ sender: Any) {
        
        // go to app store :D
    }
    
}


