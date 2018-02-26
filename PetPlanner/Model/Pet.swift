//
//  Pet.swift
//  PetPlanner
//
//  Created by Caroline Davis on 26/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation

class Pet {
    private var _imageURL: String
    private var _petName: String
    private var _petDob: String
    private var _petSpecies: String
    private var _petSex: String
    private var _petTag: String
    
    
    var imageURL: String {
        return _imageURL
    }
    
    var petName: String {
        return _petName
    }
    
    var petDob: String {
        return _petDob
    }
    
    var petSpecies: String {
        return _petSpecies
    }
    
    var petSex: String {
        return _petSex
    }
    
    var petTag: String {
        return _petTag
    }
    
    init(imageURL: String, petName: String, petDob: String, petSpecies: String, petSex: String, petTag: String) {
        _imageURL = imageURL
        _petName = petName
        _petDob = petDob
        _petSpecies = petSpecies
        _petSex = petSex
        _petTag = petTag
        
    }
}











