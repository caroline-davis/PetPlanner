//
//  LoginVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 18/1/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var toggleSignIn: UISegmentedControl!
    
    var userEmailAndPasswords = [[String: String]]()
    var alreadySignedUp = true

    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
      
    }
    override func viewDidAppear(_ animated: Bool) {
        
        // if user has already logged in before and are reopening the app
        if KeychainWrapper.standard.string(forKey: KEY_UID) != nil {
            
            //TO DO: perform the segue straight to home screen and skip login
        }
    }
    
    @IBAction func signInWithFacebook(_ sender: UIButton) {
        // TO DO: add facebook pod and sign in with facebook
    }
    
    
    @IBAction func signInWithEmail(_ sender: UIButton) {
        
        // self.activityIndicator.startAnimating()
        
        if emailField.text != "" && passwordField.text != "" {
            let email = emailField.text
            let password = passwordField.text
            
            if alreadySignedUp == true {
                // log in - log in with firebase and get their existing user id
                Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                    
                    if (error != nil) {
                        //     self.alerts(message: "\(error!.localizedDescription)")
                        //     self.activityIndicator.stopAnimating()
                    } else {
                        
                        self.completeSignIn(user: user!)
                    }
                }
                
            } else {
                // register new user - create new user and create new user id
                Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                    
                    if (error != nil) {
                        //   self.alerts(message: "\(error!.localizedDescription)")
                        //    self.activityIndicator.stopAnimating()
                    } else {
                        self.completeSignIn(user: user!)
                    }
                }
            }
        } else {
            //   self.alerts(message: "Please type something in the login fields")
            //   activityIndicator.stopAnimating()
        }
        
    }
        
        func completeSignIn(user: UserInfo) {
            
            let keychainResult = KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
            //  TO DO: Perfom segue to go to the home screen
            
        }
        
        
        @IBAction func emailSegmentClicked(_ sender: AnyObject) {
            if(toggleSignIn.selectedSegmentIndex == 0) {
                alreadySignedUp = true
            } else if (toggleSignIn.selectedSegmentIndex == 1) {
                alreadySignedUp = false
            }
            
        }
        
    

}

