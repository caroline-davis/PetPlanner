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
import MessageUI

class HomeVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var emailButton: UIBarButtonItem!
    @IBOutlet weak var addPet: ImgAndTxtBtn!
    @IBOutlet weak var viewPets: ImgAndTxtBtn!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         activityIndicator.isHidden = true
         activityIndicator.stopAnimating()
    }
    

    
    @IBAction func twitter(_sender: AnyObject) {
       if let url = NSURL(string: "https://www.twitter.com/cherrytopstudio"){ UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil) }
        
    }
    
    @IBAction func email(_sender: AnyObject) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["hello@cherrytopstudio.com"])
            mail.setSubject("Pet Planner App")
            present(mail, animated: true)
        } else {
           alerts(title: "Error", message: "Unable to send mail")
        }
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    @IBAction func createAPetProfile(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    @IBAction func viewPetsProfiles(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    @IBAction func logout(_ sender: AnyObject) {
        DataService.ds.logout(uid: KEY_UID)
        
        print("CAROL:ITS LOGGED OUT")
        
        //  let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        self.present(vc, animated: false, completion: nil)
        
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
