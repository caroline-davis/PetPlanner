//
//  ForgotPasswordVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 22/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ForgotPasswordVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        emailField.delegate = self
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        DataService.ds.forgotPassword(email: emailField.text!, completion: { error in
            if error != nil {
                
                self.alerts(title: "Error", message: "\(error?.localizedDescription.capitalized ?? "Error Occurred")")
            } else {
                self.alerts(title: "Success", message: "Please check your email to update your password")
            }
        })
    }
    
    
    @IBAction func goToLoginVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc, animated: false, completion: nil)
        
    }
    
    // when enter is pressed keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // puts cursor at the end of the text for the editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let endPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
    }
    
}


