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
    


}
