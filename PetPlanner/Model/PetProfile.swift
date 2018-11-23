//
//  Pet.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase

class PetProfile {
    
    private var _profileImage: String!
    private var _name: String!
    private var _dob: String!
    private var _species: String!
    private var _sex: String!
    private var _idTag: String!
    
    private var _petId: String!
    private var _profileRef: DatabaseReference!
    
    var profileImage: String {
        return _profileImage
    }
    var name: String {
        return _name
    }
    var dob: String {
        return _dob
    }
    var species: String {
        return _species
    }
    var sex: String {
        return _sex
    }
    var idTag: String {
        return _idTag
    }
    var petId: String {
        return _petId
    }
    
    init(profileImage: String, name: String, dob: String, species: String,sex: String, idTag: String) {
        self._profileImage = profileImage
        self._name = name
        self._dob = dob
        self._species = species
        self._sex = sex
        self._idTag = idTag
    }
    
    init(petId: String, profileData: Dictionary <String, AnyObject>) {
        self._petId = petId
        
        if let profileImage = profileData["profileImage"] as? String {
            self._profileImage = profileImage
        }
        if let name = profileData["name"] as? String {
            self._name = name
        }
        if let dob = profileData["dob"] as? String {
            self._dob = dob
        }
        if let species = profileData["species"] as? String {
           self._species = species
        }
        if let sex = profileData["sex"] as? String {
            self._sex = sex
        }
        if let idTag = profileData["idTag"] as? String {
            self._idTag = idTag
        }
        _profileRef = DataService.ds.DB_BASE.child("pets").child(_petId)
    }
    
    // for the extraction of info for the export pet file
    func toDict() -> [String: String] {
        var dict = [String: String]()

        dict["dob"] = self._dob
        dict["species"] = self._species
        dict["sex"] = self._sex
        dict["idTag"] = self._idTag
      
        return dict
    }
}











