//
//  CreatePetVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//
import AVFoundation
import UIKit
import Firebase
import SDWebImage

class CreatePetVC: UIViewController, UITextFieldDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var speciesField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var idTagField: UITextField!
    
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var profilePic: CircularImgView!
    
    var profileImage: String!
    var petId: String!
    
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        dobField.delegate = self
        speciesField.delegate = self
        sexField.delegate = self
        idTagField.delegate = self
        
        imagePicker = UIImagePickerController()
        // makes it so the user can move the image to the square they want it cropped at
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
   
        
    }
    
    @IBAction func addProfilePic(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // standard func for profile pic
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        save.isUserInteractionEnabled = false
        print("CAROL: button disabled")
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profilePic.image = image
            
            // uploading of the image and compressing it
            if let imageData = UIImageJPEGRepresentation(image, 0.2) {
                
                // the unique id
                let imageId = NSUUID().uuidString
                
                // safety to tell code what type of file the image is
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                
                DataService.ds.STORAGE_BASE.child("pets").child(imageId).putData(imageData, metadata: metaData) { (metaData, error) in
                    if error != nil {
                        print("CAROL: Unable to upload image to firebase storage", error!)
                        self.save.isUserInteractionEnabled = true
                        print("CAROL: button enabled - it didnt work")
                    } else {
                        print("CAROL: Successfully uploaded image to firebase storage")
                        let downloadURL = metaData?.downloadURL()?.absoluteString
                        if let url = downloadURL {
                            self.profileImage = url
                            self.save.isUserInteractionEnabled = true
                            print("CAROL: button enabled - it worked")
                        }
                    }
                }
            }
        } else {
            print("CAROL: A valid image wasnt selected")
            self.save.isUserInteractionEnabled = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveClicked() {
        // TODO: Determine if this pet exists or not already
        // so that when we come back to edit we don't create a new pet
        // set petId on segue
        
        guard case let name = nameField.text, name != "" else {
            self.alerts(message: "Please provide your pet's name")
            return
        }
        
        
        let dob = dobField.text
        let idTag = idTagField.text
        let species = speciesField.text
        let sex = sexField.text
        
        
        // had to set default img in firebase to get the string for this section
        let image = self.profileImage != nil ? self.profileImage : DEFAULT_PROFLE_IMAGE
        
        
        DataService.ds.createPet(
            dob: dob!,
            idTag: idTag!,
            name: name!,
            profileImage: image!,
            sex: sex!,
            species: species!,
            completion: { (error, petId) in
                
                if error != nil {
                    self.alerts(message: error!)
                } else {
                    self.goToPetProfileVC(petId: petId)
                }
        })
    }
    
    func goToPetProfileVC(petId: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PetProfileVC") as! PetProfileVC
        vc.petId = petId
        self.navigationController?.pushViewController(vc, animated: false)
        //  self.present(vc, animated: false, completion: nil)
    }
    
}
