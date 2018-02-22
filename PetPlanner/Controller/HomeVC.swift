//
//  HomeVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 18/1/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class HomeVC: UIViewController {

    @IBOutlet weak var logOutBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
        @IBAction func logoutAction(_ sender: AnyObject) {
            DataService.ds.logout(uid: KEY_UID)
            
            print("CAROL:ITS LOGGED OUT")
            
          //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            
            self.present(vc, animated: false, completion: nil)

    }
    


    

}
