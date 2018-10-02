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

class TakePhotoVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    var imagePickerController : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        photo.isHidden = true
        DispatchQueue.main.async {
            self.parent?.present(self.imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
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
                    
                    let thumb = image.resizeWithPercent(percentage: 0.1)!
                    let thumbImageData = thumb.jpegData(compressionQuality: 0.0)!
                    
                    DataService.ds.STORAGE_BASE.child("pets").child("thumbs").child(imageId).putData(thumbImageData, metadata: metaData) { (metaData, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        } else {
                            let thumbDownloadURL = metaData?.downloadURL()?.absoluteString
                            //store downloadURL at database
                            DataService.ds.DB_BASE.child("photos").child(imageId).setValue(["photo": downloadURL as Any, "thumb": thumbDownloadURL as Any, "userId": USER_ID, "petId": CURRENT_PET_ID, "imageId": imageId]) {
                                
                                print("finished")
                            }
                        }
                        
                    }
                }
            }
        }
        dismiss(animated: true, completion: nil)
        // puts the display back to the tab 0 which is gallery to view the pic in the gallery
        tabBarController?.selectedIndex = 0
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
