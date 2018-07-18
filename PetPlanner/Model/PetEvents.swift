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
    private var _eventName: String!
    private var _location: String!
    private var _date: Int!
    private var _startTime: Int!
    private var _endTime: Int!
    
    private var _eventsRef: DatabaseReference!
    
    var petId: String {
        return _petId
    }
    var name: String {
        return _name
    }
    var eventName: String {
        return _eventName
    }
    var location: String {
        return _location
    }
    var date: Int {
        return _date
    }
    var startTime: Int {
        return _startTime
    }
    var endTime: Int {
        return _endTime
    }
    var eventsRef: DatabaseReference {
        return _eventsRef
    }
    
    init(petId: String, name: String, eventName: String, location: String, date: Int, startTime: Int, endTime: Int) {
        self._petId = petId
        self._name = name
        self._eventName = eventName
        self._location = location
        self._date = date
        self._startTime = startTime
        self._endTime = endTime
    }
    
    init(petId: String, eventsData: Dictionary <String, AnyObject>)  {
        self._petId = petId
        
        if let name = eventsData["name"] as? String {
            self._name = name
        }
        if let eventName = eventsData["eventName"] as? String {
            self._eventName = eventName
        }
        if let location = eventsData["location"] as? String {
            self._location = location
        }
        if let date = eventsData["date"] as? Int {
            self._date = date
        }
        if let startTime = eventsData["startTime"] as? Int {
            self._startTime = startTime
        }
        if let endTime = eventsData["endTime"] as? Int {
            self._endTime = endTime
        }
        _eventsRef = DataService.ds.DB_BASE.child("events").child(_petId)
    }
    

    
    
}
