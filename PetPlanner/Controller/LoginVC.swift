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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userEmailAndPasswords = [[String: String]]()
    var alreadySignedUp = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        activityIndicator.isHidden = true
        
    }
    

    
    @IBAction func signInWithEmail(_ sender: UIButton) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if emailField.text != "" && passwordField.text != "" {
            let email = emailField.text
            let password = passwordField.text
            
            if alreadySignedUp == true {
                // log in - log in with firebase and get their existing user id
                Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                    
                    if (error != nil) {
                        self.alerts(message: "\(error!.localizedDescription)")
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    } else {
                        
                        self.completeSignIn(user: user!)
                    }
                }
                
            } else {
                // register new user - create new user and create new user id
                Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                    
                    if (error != nil) {
                        self.alerts(message: "\(error!.localizedDescription)")
                        self.activityIndicator.stopAnimating()
                    } else {
                        self.completeSignIn(user: user!)
                    }
                }
            }
        } else {
            self.alerts(message: "Please type something in the login fields")
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
        
    }
    
    func completeSignIn(user: UserInfo) {
        
        // let keychainResult =
        _ = KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
        
        //  Perfom segue to go to the home screen
        let controller = self.storyboard?.instantiateViewController(withIdentifier:"NavController") as! UINavigationController
        self.present(controller, animated: false, completion: nil)
        
        
    }
    
    
    @IBAction func emailSegment(_ sender: AnyObject) {
        if(toggleSignIn.selectedSegmentIndex == 0) {
            alreadySignedUp = true
        } else if (toggleSignIn.selectedSegmentIndex == 1) {
            alreadySignedUp = false
        }
        
    }
    
    @IBAction func goToForgotPasswordVC(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ForgotPasswordVC") as! ForgotPasswordVC
        self.present(vc, animated: false, completion: nil)
        
    }
    
    // when enter is pressed keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}

