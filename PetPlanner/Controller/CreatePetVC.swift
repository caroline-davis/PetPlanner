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
import IQKeyboardManagerSwift

class CreatePetVC: UIViewController, UITextFieldDelegate,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
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
        
        activityIndicator.isHidden = true
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        loadingActivityIndicator.isHidden = false
        loadingActivityIndicator.startAnimating()
        
        // if the user clicks edit on the viewpets page - this will open the screen with that same petId for the user to edit
        if petId != nil {
            DataService.ds.getPet(petId: petId) { (petProfile) in
                self.pet = petProfile
                
                // gets image from firebase using sdwebimage
                self.profilePic.sd_setImage(with: URL(string: self.pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { (profilePic, error, cacheType, URL) in
                })
                
                self.profileImage = self.pet.profileImage
                
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
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadingActivityIndicator.isHidden = true
        loadingActivityIndicator.stopAnimating()
    }

    
    @IBAction func addProfilePic(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // standard func for profile pic
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        saveBtnDisabled(save: self.save, activityIndicator: self.activityIndicator)
        print("CAROL: button disabled")
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            profilePic.image = image
            
            // uploading of the image and compressing it
            if let imageData = image.jpegData(compressionQuality: 0.2) {
                
                // the unique id
                let imageId = NSUUID().uuidString
                
                // safety to tell code what type of file the image is
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpeg"
                
                DataService.ds.STORAGE_BASE.child("pets").child(imageId).putData(imageData, metadata: metaData) { (metaData, error) in
                    if error != nil {
                        print("CAROL: Unable to upload image to firebase storage", error!)
                        
                        saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
                        print("CAROL: button enabled - it didnt work")
                    } else {
                        print("CAROL: Successfully uploaded image to firebase storage")
                        let downloadURL = metaData?.downloadURL()?.absoluteString
                        if let url = downloadURL {
                            self.profileImage = url
                            saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
                            print("CAROL: button enabled - it worked")
                        }
                    }
                }
            }
        } else {
            print("CAROL: A valid image wasnt selected")
            saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveProfile() {
        // Determine if this pet exists or not already
        // so that when we come back to edit we don't create a new pet
        
        saveBtnDisabled(save: save, activityIndicator: activityIndicator)
        
        guard case let name = nameField.text, name != "" else {
            self.alerts(title: "Error", message: "Please provide your pet's name")
            saveBtnEnabled(save: save, activityIndicator: activityIndicator)
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
                    self.alerts(title: "Error", message: error!)
                } else {
                    saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
                    self.goToPetProfileVC(petId: petId)
                }
        })
        } else {
            // if edit is clicked, the values update and save on firebase
            DataService.ds.editPet(petId: petId, dob: dob!, name: name!, idTag: idTag!, sex: sex!, species: species!, profileImage: image!, completion: { (error) in
                
                    if error != nil {
                        self.alerts(title: "Error", message: error!)
                    } else {
                        print("it worked")
                    }
                 saveBtnEnabled(save: self.save, activityIndicator: self.activityIndicator)
            })
            self.goToPetProfileVC(petId: petId)
        }
    }
  
    func goToPetProfileVC(petId: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PetProfileVC") as! PetProfileVC
        vc.petId = petId
        self.navigationController?.pushViewController(vc, animated: false)
        //  self.present(vc, animated: false, completion: nil)
    }
    
    // when enter is pressed keyboard is dismissed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // puts curser at the end of the text for the editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let endPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
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



