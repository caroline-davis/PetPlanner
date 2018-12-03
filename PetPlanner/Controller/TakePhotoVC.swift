//
//  TakePhotoVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 4/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class TakePhotoVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    var imagePickerController : UIImagePickerController!
    var loadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            
            self.imagePickerController = UIImagePickerController()
            self.imagePickerController.delegate = self
            self.imagePickerController.sourceType = .camera
            
            self.tabBarController?.delegate = self
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // photo.isHidden = true
        DispatchQueue.main.async {
            self.photo.isHidden = true
            
            self.parent?.present(self.imagePickerController, animated: true, completion: nil)
            
            if (self.loadingActivityIndicator == nil) {
                self.loadingActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
                self.loadingActivityIndicator.center = self.imagePickerController.view.center
                
                self.imagePickerController.view.addSubview(self.loadingActivityIndicator)
                self.imagePickerController.view.bringSubviewToFront(self.loadingActivityIndicator)
            }
            
        }
        
    }
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        DispatchQueue.main.async {
            self.loadingActivityIndicator.isHidden = false
            self.loadingActivityIndicator.startAnimating()
        }
        
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            photo.image = image
            
            // the unique id
            let imageId = DataService.ds.generateId()
            
            // set metadata
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            let imageData = image.jpegData(compressionQuality: 0.0)!
            
            DataService.ds.STORAGE_BASE.child("pets").child(imageId).putData(imageData, metadata: metaData) { (metaData, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    
                    DataService.ds.DB_BASE.child("photos").child(imageId).setValue([
                        "photo": downloadURL,
                        "userId": USER_ID,
                        "petId": CURRENT_PET_ID,
                        "imageId": imageId
                    ]) { (data, error) in
                        DispatchQueue.main.async {
                            self.loadingActivityIndicator.isHidden = true
                            self.loadingActivityIndicator.stopAnimating()
                        }
                        // if error or complete the user goes back to other screen
                        self.dismiss(animated: true, completion: nil)
                        // puts the display back to the tab 0 which is gallery to view the pic in the gallery
                        self.tabBarController?.selectedIndex = 0
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        // puts the display back to the tab 0 which is gallery
        tabBarController?.selectedIndex = 0
    }
  
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
