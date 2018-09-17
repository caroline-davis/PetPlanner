//
//  ForgotPasswordVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 22/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        DataService.ds.forgotPassword(email: emailField.text!, completion: { error in
            print("here")
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
    

}


