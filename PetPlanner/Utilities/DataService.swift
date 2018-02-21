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
    
    func logout(uid: String) {
        
        // remove saved user id key
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("CAROL: ID removed from keychain \(keychainResult)")
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("CAROL: Error signing out: %@", signOutError)
        }
    }
    
    
    
}
