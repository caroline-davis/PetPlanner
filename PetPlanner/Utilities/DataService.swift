//
//  DataService.swift
//  PetPlanner
//
//  Created by Caroline Davis on 21/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper


class DataService {
    
    static let ds = DataService()
    var firebaseAuth = Auth.auth()
    
    // this contains the URL of the root of the database and storagebase(this is taken from GoogleService.plist file)
    let DB_BASE = Database.database().reference()
    let STORAGE_BASE = Storage.storage().reference()
    
    
    func logout(uid: String) {
        
        // remove saved user id key
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CAROL: ID removed from keychain \(keychainResult)")
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("CAROL: Error signing out: %@", signOutError)
        }
    }
    
    func forgotPassword(email: String) {
        
   
            firebaseAuth.sendPasswordReset(withEmail: email) { error in
                // todo callback for error
                // form with email address.... send button. if email is incorrect it would show error, if not it would say check email
        }
        
    }
    
    func generateId() -> String {
        let key = DB_BASE.childByAutoId().key
        return key
    }
    
    func createPet(
        dob: String,
        idTag: String,
        name: String,
        profileImage: String,
        sex: String,
        species: String,
        completion: @escaping (String?, _ petId: String)->()) {
        
        let petId = generateId()
        
        DB_BASE.child("pets").child(petId).setValue([
            "dob": dob,
            "idTag": idTag,
            "name": name,
            "petId": petId,
            "profileImage": profileImage,
            "sex": sex,
            "species": species,
            "userId": USER_ID
        ]) { (error, result) in
         
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")", petId)
            } else {
                completion(nil, petId)
            }

        }

    }
    
    
    func getPet(petId: String, completion: @escaping (PetProfile?)->()) {
        
        DB_BASE.child("pets").child(petId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary <String, AnyObject>
            if value != nil {
                let pet = PetProfile(petId: petId, profileData: value!)
                print(pet)
                completion(pet)
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func getAllPets(completion: @escaping (Array<PetProfile>)->()) {
        
         DB_BASE.child("pets").queryOrdered(byChild: "userId").queryEqual(toValue: USER_ID).observeSingleEvent(of: .value, with: { (snapshot) in
    
           
            let dict = snapshot.value as? Dictionary <String, AnyObject>
            
            // To get JSON data as array to loop through - it removes the keys from outer layer of dict
            
            if dict != nil {
            
            let values = Array(dict!.values)
        
            // .map calls a function for each item in array
            let pets = values.map({ (item) -> PetProfile in
                let petId = item["petId"] as! String
                return PetProfile(petId: petId, profileData: item as! Dictionary<String, AnyObject>)
                
            })
            
            completion(pets)
            } else {
                print("no pets")
            }
        })
        
    
    }
    


}

