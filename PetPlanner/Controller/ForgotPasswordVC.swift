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
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        DataService.ds.forgotPassword(email: "hello")
    }
    

    @IBAction func backToLoginVC(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(vc, animated: false, completion: nil)
        
    }
    

}
