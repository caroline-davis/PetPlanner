//
//  PetHealth.swift
//  PetPlanner
//
//  Created by Caroline Davis on 27/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase

class PetHealth {
    
    private var _breed: String!
    private var _weight: String!
    private var _vaccinations: String!
    private var _allergies: String!
    private var _medications: String!
    private var _spayedOrNeutered: String!
    private var _vet: String!
    private var _lastVetVisit: String!
    
    private var _petId: String!
    private var _healthRef: DatabaseReference!
    
    var breed: String {
        return _breed
    }
    var weight: String {
        return _weight
    }
    var vaccinations: String {
        return _vaccinations
    }
    var allergies: String {
        return _allergies
    }
    var medications: String {
        return _medications
    }
    var spayedOrNeutered: String {
        return _spayedOrNeutered
    }
    var vet: String {
        return _vet
    }
    var lastVetVisit: String {
        return _lastVetVisit
    }
    var petId: String {
        return _petId
    }

    
    init (breed: String, weight: String, vaccinations: String, allergies: String, medications: String, spayedOrNeutered: String, vet: String, lastVetVisit: String) {
        self._breed = breed
        self._weight = weight
        self._vaccinations = vaccinations
        self._allergies = allergies
        self._medications = medications
        self._spayedOrNeutered = spayedOrNeutered
        self._vet = vet
        self._lastVetVisit = lastVetVisit
        }

    
    init(petId: String, healthData: Dictionary <String, AnyObject>)  {
        self._petId = petId

        if let breed = healthData["breed"] as? String {
            self._breed = breed
        }
        if let weight = healthData["weight"] as? String {
            self._weight = weight
        }
        if let vaccinations = healthData["vaccinations"] as? String {
            self._vaccinations = vaccinations
        }
        if let allergies = healthData["allergies"] as? String {
            self._allergies = allergies
        }
        if let medications = healthData["medications"] as? String {
            self._medications = medications
        }
        if let spayedOrNeutered = healthData["spayedOrNeutered"] as? String {
            self._spayedOrNeutered = spayedOrNeutered
        }
        if let vet = healthData["vet"] as? String {
            self._vet = vet
        }
        if let lastVetVisit = healthData["lastVetVisit"] as? String {
            self._lastVetVisit = lastVetVisit
        }
        _healthRef = DataService.ds.DB_BASE.child("health").child(_petId)
        }

}

