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
    
    func forgotPassword(email: String, completion: @escaping (String?)->()) {
        
            firebaseAuth.sendPasswordReset(withEmail: email) { error in
                
                if error != nil {
                    completion("\(error?.localizedDescription.capitalized ?? "Broken")")
                    // msg is the error on a pop up.
                } else {
                    completion("send email")
                    // msg is the email is sent. check your email
                }
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
    
    func getPhotos(petId: String, completion: @escaping (Array<PetImage>)-> ()) {
        
        DB_BASE.child("photos").queryOrdered(byChild: "petId").queryEqual(toValue: petId).observe(DataEventType.value, with: { (snapshot) in
        let photoDict = snapshot.value as? Dictionary <String, AnyObject>
           
            if photoDict != nil {
                let values = Array(photoDict!.values)
                let photos = values.map({ (item) -> PetImage in
                let petId = item["petId"] as! String
                    return PetImage(petId: petId, imageData: item as! Dictionary<String, AnyObject>)
                })
                
                completion(photos)
            } else {
                print("no photos")
                
            }
        })
        
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
    
// Add the completition handler for firebase like the edithealth one
    func editPet(petId: String, dob: String, name: String, idTag: String, sex: String, species: String, profileImage: String) {
        
        DB_BASE.child("pets").child(petId).updateChildValues(["name": name, "dob": dob, "idTag": idTag, "sex": sex, "species": species, "profileImage": profileImage])
    }
    
    // HEALTH
    func getHealth(petId: String, completion: @escaping (PetHealth?)->()) {
        
        DB_BASE.child("health").child(CURRENT_PET_ID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary <String, AnyObject>
            if value != nil {
                let health = PetHealth(petId: CURRENT_PET_ID, healthData: value!)
                print(health)
                completion(health)
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func createHealth(petId: String, userId: String, breed: String, weight: String, vaccinations: String, allergies: String, medications: String, spayedOrNeutered: String, vet: String, lastVetVisit: String, completion: @escaping (String?)->()) {
        
        DB_BASE.child("health").child(CURRENT_PET_ID).setValue([
            "petId": CURRENT_PET_ID,
            "userId": USER_ID,
            "breed": breed,
            "weight": weight,
            "vaccinations": vaccinations,
            "allergies": allergies,
            "medications": medications,
            "spayedOrNeutered": spayedOrNeutered,
            "vet": vet,
            "lastVetVisit": lastVetVisit
        ]) { (error, result) in
            
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")")
            } else {
                completion(nil)
            }
        }
    }
    
    
    func editHealth(petId: String, breed: String, weight: String, vaccinations: String, allergies: String, medications: String, spayedOrNeutered: String, vet: String, lastVetVisit: String, completion: @escaping (String?)->()) {
        
        DB_BASE.child("health").child(CURRENT_PET_ID).updateChildValues(["breed": breed, "weight": weight, "vaccinations": vaccinations, "allergies": allergies, "medications": medications, "spayedOrNeutered": spayedOrNeutered, "vet": vet, "lastVetVisit": lastVetVisit])
        { (error, result) in
            
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")")
            } else {
                completion(nil)
            }
        }
    }
    
    // FAVS
    
    func getFavs(petId: String, completion: @escaping (PetFavs?)->()) {
        
        DB_BASE.child("favs").child(CURRENT_PET_ID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary <String, AnyObject>
            if value != nil {
                let favs = PetFavs(petId: CURRENT_PET_ID, favsData: value!)
                print(favs)
                completion(favs)
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func createFavs(petId: String, userId: String, food: String, drink: String, toy: String, sleepingNook: String, activity: String, hidingSpot: String, feastingTime: String, other: String, completion: @escaping (String?)->()) {
        
        DB_BASE.child("favs").child(CURRENT_PET_ID).setValue([
            "petId": CURRENT_PET_ID,
            "userId": USER_ID,
            "food": food,
            "drink": drink,
            "toy": toy,
            "sleepingNook": sleepingNook,
            "activity": activity,
            "hidingSpot": hidingSpot,
            "feastingTime": feastingTime,
            "other": other
        ]) { (error, result) in
            
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")")
            } else {
                completion(nil)
            }
        }
    }
    
    func editFavs(petId: String, food: String, drink: String, toy: String, sleepingNook: String, activity: String, hidingSpot: String, feastingTime: String, other: String, completion: @escaping (String?)->()) {
        
        DB_BASE.child("favs").child(CURRENT_PET_ID).updateChildValues(["food": food, "drink": drink, "toy": toy, "sleepingNook": sleepingNook, "activity": activity, "hidingSpot": hidingSpot, "feastingTime": feastingTime, "other": other])
        { (error, result) in
            
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")")
            } else {
                completion(nil)
            }
            
        }
    }
    
    func getEvent(petId: String, eventId: String, completion: @escaping (PetEvents?)->()) {
        
        DB_BASE.child("events").child(CURRENT_PET_ID).child(eventId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Dictionary <String, AnyObject>
            if value != nil {
                let event = PetEvents(petId: CURRENT_PET_ID, eventsData: value!)
                completion(event)
            } else {
                completion(nil)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func createEvent(
        name: String,
        location: String,
        date: Date,
        completion: @escaping (String?, _ petId: String)->()) {
        
        let eventId = generateId()
        
        
        DB_BASE.child("events").child(CURRENT_PET_ID).child(eventId).setValue([
            "petId": CURRENT_PET_ID,
            "eventId": eventId,
            "name": name,
            "location": location,
            "date": String(date.description),
            "userId": USER_ID
        ]) { (error, result) in
            
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")",  CURRENT_PET_ID)
            } else {
                completion(nil, CURRENT_PET_ID)
            }
        }
    }
    
    func editEvent(eventId: String, name: String, location: String, date: Date, completion: @escaping (String?)->()) {
        DB_BASE.child("events").child(CURRENT_PET_ID).child(eventId).updateChildValues([
            "name": name,
            "location": location,
            "date": String(date.description)
        ])
        { (error, result) in
            if error != nil {
                completion("\(error?.localizedDescription.capitalized ?? "Broken")")
            } else {
                completion(nil)
            }
        }
    }
    
    func getAllEvents(completion: @escaping (Array<PetEvents>)->()) {
        
        DB_BASE.child("events").child(CURRENT_PET_ID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let dict = snapshot.value as? Dictionary <String, AnyObject>
            
            // To get JSON data as array to loop through - it removes the keys from outer layer of dict
            
            if dict != nil {
                let values = Array(dict!.values)
                
                // .map calls a function for each item in array
                let events = values.map({ (item) -> PetEvents in
                    let petId = item["petId"] as! String
                    return PetEvents(petId: petId, eventsData: item as! Dictionary<String, AnyObject>)
                })
                
                completion(events)
            } else {
                print("no events")
            }
        })
        
    }

    

}

