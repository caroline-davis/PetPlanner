//
//  CreateEventVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    
    @IBOutlet weak var name: SquareTxtFld!
    @IBOutlet weak var location: SquareTxtFld!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveBtn: CurvedBtn!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var eventDate: Date!
    var petEvent: PetEvents!
    
    // to do: when clicking on tableview with the eventId attached
    
    var eventId: String!
    var event: PetEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        if eventId != nil {
            DataService.ds.getEvent(petId: CURRENT_PET_ID, eventId: eventId) { (petEvent) in
                self.event = petEvent
                print(self.event)
            
            if petEvent != nil {
                DispatchQueue.main.async {
                    self.name.text = self.event.name
                    self.location.text = self.event.location
                    self.eventDate = self.event.eventDate
                    self.datePicker.setDate(self.eventDate, animated: true)
                }
            }
            
        }
    }
    }
    
    
    
    @IBAction func getDateAndTime(_ sender: UIDatePicker) {
        eventDate = sender.date
        print(sender.date)
    }
    
    @IBAction func save(_ sender: Any) {
        
        saveBtnDisabled(save: saveBtn, activityIndicator: activityIndicator)
        
        guard case let date = eventDate, date != nil else {
            self.alerts(title: "Error", message: "Please select a date and time")
             saveBtnEnabled(save: saveBtn, activityIndicator: activityIndicator)
            return
        }
        guard case let eventName = name.text, eventName != "" else {
            self.alerts(title: "Error", message: "Please enter an event name")
            saveBtnEnabled(save: saveBtn, activityIndicator: activityIndicator)
            return
        }
        guard case let locationName = location.text, locationName != "" else {
            self.alerts(title: "Error", message: "Please enter a location")
             saveBtnEnabled(save: saveBtn, activityIndicator: activityIndicator)
            return
        }
        
        if self.event == nil {
            DataService.ds.createEvent(name: name.text!, location: location.text!, eventDate: eventDate!, completion: { (error, petId) in
                if error != nil {
                    self.alerts(title: "Error", message: error!)
                } else {
                    print("it worked")
                }
                saveBtnEnabled(save: self.saveBtn, activityIndicator: self.activityIndicator)
                self.navigationController?.popViewController(animated: true)
            })
        } else {
            DataService.ds.editEvent(eventId: self.event.eventId, name: name.text!, location: location.text!, eventDate: eventDate!, completion:{ (error) in
                if error != nil {
                    self.alerts(title: "Error", message: error!)
                } else {
                    print("it worked")
                }
                saveBtnEnabled(save: self.saveBtn, activityIndicator: self.activityIndicator)
            })
        }
    }
    
    
}
