//
//  CreateEventVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

extension Date {
    var localizedDescription: String {
        return description(with: .current)
    }
}

class CreateEventVC: UIViewController {
    
    @IBOutlet weak var name: SquareTxtFld!
    @IBOutlet weak var location: SquareTxtFld!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var eventDate: Date!
    var petEvent: PetEvents!
    
    // to do: when clicking on tableview with the eventId attached
    
    var eventId: String!
    var event: PetEvents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if eventId != nil {
            DataService.ds.getEvent(petId: CURRENT_PET_ID, eventId: eventId) { (petEvent) in
                self.event = petEvent
            
            if petEvent != nil {
                DispatchQueue.main.async {
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
        if self.event == nil {
            DataService.ds.createEvent(name: name.text!, location: location.text!, eventDate: eventDate!, completion: { (error, petId) in
                if error != nil {
                    self.alerts(message: error!)
                } else {
                    print("it worked")
                }
            })
        } else {
            DataService.ds.editEvent(eventId: self.event.eventId, name: name.text!, location: location.text!, eventDate: eventDate!, completion:{ (error) in
                if error != nil {
                    self.alerts(message: error!)
                } else {
                    print("it worked")
                }
            })
        }
    }
    
    
}
