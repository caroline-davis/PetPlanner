//
//  PetEvents.swift
//  PetPlanner
//
//  Created by Caroline Davis on 27/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase


class PetEvents {
    
    private var _petId: String!
    private var _name: String!
    private var _location: String!
    private var _date: Date!
    private var _userId: String!
    private var _eventId: String!

    
    private var _eventsRef: DatabaseReference!
    
    var petId: String {
        return _petId
    }
    var name: String {
        return _name
    }
    var location: String {
        return _location
    }
    var date: Date {
        return _date
    }
    var userId: String {
        return _userId
    }
    var eventId : String {
        return _eventId
    }

    var eventsRef: DatabaseReference {
        return _eventsRef
    }
    
    init(petId: String, name: String, location: String, date: String, userId: String, eventId: String) {
        self._petId = petId
        self._name = name
        self._location = location
        let formatter = DateFormatter()
        self._date = formatter.date(from: date)
        self._userId = userId
        self._eventId = eventId
      
    }
    
    init(petId: String, eventsData: Dictionary <String, AnyObject>)  {
        self._petId = petId
        
        if let name = eventsData["name"] as? String {
            self._name = name
        }
        if let location = eventsData["location"] as? String {
            self._location = location
        }
        if let date = eventsData["date"] as? String {
            let formatter = DateFormatter()
            self._date = formatter.date(from: date)
        }
        if let userId = eventsData["userId"] as? String {
            self._userId = userId
        }
        if let eventId = eventsData["eventId"] as? String {
            self._eventId = eventId
        }
        _eventsRef = DataService.ds.DB_BASE.child("events").child(_petId).child(eventId)
    }
    

    
    
}
