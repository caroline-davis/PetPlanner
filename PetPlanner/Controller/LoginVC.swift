//
//  LoginVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 18/1/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import IQKeyboardManagerSwift
import Firebase
import FacebookCore
import FacebookLogin

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var toggleSignIn: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var facebookBtn: CircularBtn!
    
    var userEmailAndPasswords = [[String: String]]()
    var alreadySignedUp = true
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailField.delegate = self
        passwordField.delegate = self
        activityIndicator.isHidden = true
    }
    
    @IBAction func signInWithFacebook(_ sender: Any) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            alerts(title: "Error", message: "This app needs an internet connection to run")
            print("Internet Connection not Available!")
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile], viewController : self) { loginResult in
            
            switch loginResult {
            case .failed(let error):
                print(error)
                self.alerts(title: "Error", message: error.localizedDescription)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            case .cancelled:
                print("User cancelled login")
                self.alerts(title: "Error", message: "User has cancelled login")
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            case .success( _, _, let accessToken):
                print("Logged in")
                // User succesfully logged in. Contains granted, declined permissions and access token.
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.firebaseAuth(credential)
            }
        }
    }
    
    // link the fb log in with firebase authentication
    func firebaseAuth(_ credential: AuthCredential) {
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil) {
                self.alerts(title: "Error", message: "Sorry we are unable to authenticate you, please try again")
            } else {
                self.completeSignIn(user: user!)
                
            }
        }
        
    }
    
    
    @IBAction func signInWithEmail(_ sender: UIButton) {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        }else{
            alerts(title: "Error", message: "This app needs an internet connection to run")
            print("Internet Connection not Available!")
        }
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        if emailField.text != "" && passwordField.text != "" {
            let email = emailField.text
            let password = passwordField.text
            
            if alreadySignedUp == true {
                // log in - log in with firebase and get their existing user id
                Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                    
                    if (error != nil) {
                        self.alerts(title: "Error", message: "\(error!.localizedDescription)")
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
                        self.alerts(title: "Error", message: "\(error!.localizedDescription)")
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                    } else {
                        self.completeSignIn(user: user!)
                    }
                }
            }
        } else {
            self.alerts(title: "Error", message: "Please type something in the login fields")
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
        
    }
    
    func completeSignIn(user: UserInfo) {
        
        // let keychainResult =
        _ = KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
        USER_ID = user.uid
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

