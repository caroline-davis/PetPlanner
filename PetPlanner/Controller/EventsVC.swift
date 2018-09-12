//
//  EventsVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
  //  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var name: UILabel!
    
    var tableViewData = [PetEvents]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.rowHeight = 100
        
        // tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
        
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(false)
            
            DataService.ds.getAllEvents { (events) in
                self.tableViewData = events
                self.tableView.reloadData()
            }
            
        //    self.activityIndicator.isHidden = false
         //   self.activityIndicator.startAnimating()
            
    // do a getpetEVENts data in dataservice and put it here

            //    self.activityIndicator.isHidden = true
            //    self.activityIndicator.stopAnimating()
            
            
            
            
        }
        
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableViewData.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell {
                let pet = self.tableViewData[indexPath.row]
                cell.tag = indexPath.row
                
                
                cell.configure(petEvent: pet)
                
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let event = self.tableViewData[indexPath.row]
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateEventVC") as! CreateEventVC
            vc.eventId = event.eventId
            self.navigationController?.pushViewController(vc, animated: false)
            
        }
        
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            
            let event = self.tableViewData[indexPath.row]
            let eventId = event.eventId
            
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                // delete item at indexPath
                print("delete tapped")
                
                self.tableViewData.remove(at: indexPath.row)
                self.tableView.reloadData()
                
                // removes the data from firebase
                DataService.ds.DB_BASE.child("events").child(CURRENT_PET_ID).child(eventId).removeValue()
                
                //  // removes the data from firebase
                // DataService.ds.DB_BASE.child("pets").child(petId).removeValue()
                
            }
            delete.backgroundColor = .red
            
            let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
                print("edit tapped")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateEventVC") as! CreateEventVC
               vc.eventId = event.eventId
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
