//
//  Petimage.swift
//  PetPlanner
//
//  Created by Caroline Davis on 1/5/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase

class PetImage {
    
    private var _imageId: String!
    private var _photo: String!
    private var _userId: String!
    
    private var _petId: String!
    private var _imageRef: DatabaseReference!

    var imageId: String {
        return _imageId
    }
    
    var photo: String {
        return _photo
    }
    
    var userId: String {
        return _userId
    }
    
    var petId: String {
        return _petId
    }
    
    init(imageId: String, photo: String, userId: String) {
        self._imageId = imageId
        self._photo = photo
        self._userId = userId
    
    }
    
    init(petId: String, imageData: Dictionary <String, AnyObject>)  {

        self._petId = petId

        if let imageId = imageData["imageId"] as? String {
            self._imageId = imageId
        }
        if let photo = imageData["photo"] as? String {
            self._photo = photo
        }
        if let userId = imageData["userId"] as? String {
            self._userId = userId
        }
    
    _imageRef = DataService.ds.DB_BASE.child("photos").child(_imageId)
    }
}
