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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var profileImage: String!
    var petId: String!
    var pet: PetProfile!
    
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
   
        activityIndicator.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // if the user clicks edit on the viewpets page - this will open the screen with that same petId for the user to edit
        
        if petId != nil {
            DataService.ds.getPet(petId: petId) { (petProfile) in
                self.pet = petProfile
                
                // gets image from firebase using sdwebimage
                self.profilePic.sd_setImage(with: URL(string: self.pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { (profilePic, error, cacheType, URL) in
                    
                })
                
                DispatchQueue.main.async {
                    self.nameField.text = self.pet.name
                    self.dobField.text = self.pet.dob
                    self.speciesField.text = self.pet.species
                    self.sexField.text = self.pet.sex
                    self.idTagField.text = self.pet.idTag
                    
                }
                
            }
        }
    }
    
    @IBAction func addProfilePic(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // standard func for profile pic
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        save.isUserInteractionEnabled = false
        save.titleLabel?.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
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
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.save.titleLabel?.isHidden = false
                        print("CAROL: button enabled - it didnt work")
                    } else {
                        print("CAROL: Successfully uploaded image to firebase storage")
                        let downloadURL = metaData?.downloadURL()?.absoluteString
                        if let url = downloadURL {
                            self.profileImage = url
                            self.save.isUserInteractionEnabled = true
                            self.activityIndicator.isHidden = true
                            self.activityIndicator.stopAnimating()
                            self.save.titleLabel?.isHidden = false
                            print("CAROL: button enabled - it worked")
                        }
                    }
                }
            }
        } else {
            print("CAROL: A valid image wasnt selected")
            self.save.isUserInteractionEnabled = true
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.save.titleLabel?.isHidden = false
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveClicked() {
        // TODO: Determine if this pet exists or not already
        // so that when we come back to edit we don't create a new pet
        
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
        
        if petId == nil {
        
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
        } else {
            // if edit is clicked, the values update and save on firebase
            DataService.ds.editPet(petId: petId, dob: dob!, name: name!, idTag: idTag!, sex: sex!, species: species!)
            
            // TO DO: update the profile image if it has been changed
     
        }
        
    }
    
  
    
    func goToPetProfileVC(petId: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PetProfileVC") as! PetProfileVC
        vc.petId = petId
        self.navigationController?.pushViewController(vc, animated: false)
        //  self.present(vc, animated: false, completion: nil)
    }
    
}

