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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tableViewData = [PetProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.rowHeight = 100
            
            self.addPet.isHidden = true
            self.addPet.isEnabled = false
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DataService.ds.getAllPets { (pets) in
            if pets != nil {
                self.addPet.isHidden = true
                self.addPet.isEnabled = false
                self.tableViewData = pets!
                self.tableView.reloadData()
            } else if pets == nil {
                self.addPet.isHidden = false
                self.addPet.isEnabled = true
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
        
        let pet = self.tableViewData[indexPath.row]
        let petId = pet.petId
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            
            // delete item at indexPath
            self.tableViewData.remove(at: indexPath.row)
            self.tableView.reloadData()
            
            // if after deletion there are 0 pets, sets the add pet button back
            if self.tableViewData.count == 0 {
                self.addPet.isHidden = false
                self.addPet.isEnabled = true
            }
            
            // removes the data from firebase
            DataService.ds.DB_BASE.child("pets").child(petId).removeValue()
        }
        delete.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            
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
        } else {
            cell.backgroundColor = BLUE_COLOR
        }
    }
    
    @IBAction func addPet(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreatePetVC") as! CreatePetVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
    }
    
    
}


