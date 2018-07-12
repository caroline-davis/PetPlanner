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
       // DataService.ds.forgotPassword(email: "hello", completion: <#(String?) -> ()#>)
    }
    
   // or //    Auth.auth().sendPasswordReset(withEmail: "email@email") { error in
    //    // Your code here
    //    }
    
    
    
    @IBAction func goToLoginVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc, animated: false, completion: nil)
        
    }
    

}


