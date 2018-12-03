//
//  PetFavs.swift
//  PetPlanner
//
//  Created by Caroline Davis on 27/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase

class PetFavs {
    
    private var _food: String!
    private var _drink: String!
    private var _sleepingNook: String!
    private var _activity: String!
    private var _hidingSpot: String!
    private var _feastingTime: String!
    private var _toy: String!
    private var _other: String!
    
    private var _petId: String!
    private var _favsRef: DatabaseReference!
    
    var food: String {
        return _food
    }
    var drink: String {
        return _drink
    }
    var sleepingNook: String {
        return _sleepingNook
    }
    var activity: String {
        return _activity
    }
    var hidingSpot: String {
        return _hidingSpot
    }
    var feastingTime: String {
        return _feastingTime
    }
    var toy: String {
        return _toy
    }
    var other: String {
        return _other
    }
    var petId: String {
        return _petId
    }
    
    init (food: String, drink: String, sleepingNook: String, friend: String, activity: String, hidingSpot: String, feastingTime: String, toy: String, Other: String) {
        self._food = food
        self._drink = drink
        self._sleepingNook = sleepingNook
        self._activity = activity
        self._hidingSpot = hidingSpot
        self._feastingTime = feastingTime
        self._toy = toy
        self._other = other
    }
    
    
    init(petId: String, favsData: Dictionary <String, AnyObject>)  {
        self._petId = petId
        
        if let food = favsData["food"] as? String {
            self._food = food
        }
        if let drink = favsData["drink"] as? String {
            self._drink = drink
        }
        if let sleepingNook = favsData["sleepingNook"] as? String {
            self._sleepingNook = sleepingNook
        }
        if let activity = favsData["activity"] as? String {
            self._activity = activity
        }
        if let hidingSpot = favsData["hidingSpot"] as? String {
            self._hidingSpot = hidingSpot
        }
        if let feastingTime = favsData["feastingTime"] as? String {
            self._feastingTime = feastingTime
        }
        if let toy = favsData["toy"] as? String {
            self._toy = toy
        }
        if let other = favsData["other"] as? String {
            self._other = other
        }
        _favsRef = DataService.ds.DB_BASE.child("favs").child(_petId)
    }
    
    // for the extraction of info for the export pet file
    func toDict() -> [String: String] {
        var dict = [String: String]()
        
        dict["food"] = self._food
        dict["drink"] = self._drink
        dict["sleepingNook"] = self._sleepingNook
        dict["activity"] = self._activity
        dict["hidingSpot"] = self._hidingSpot
        dict["feastingTime"] = self._feastingTime
        dict["toy"] = self._toy
        dict["other"] = self._other
        return dict
    }  
}
