//
//  TakePhotoVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 4/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class TakePhotoVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photo: UIImageView!
    var imagePickerController : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        
        present(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePickerController.dismiss(animated: true, completion: nil)
        
        photo.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }

 

}
