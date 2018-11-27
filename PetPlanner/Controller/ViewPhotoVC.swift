//
//  ViewPhotoVC.swift
//  PetPlanner
//
//  Created by Caroline Davis on 4/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewPhotoVC: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var send: UIBarButtonItem!
    @IBOutlet weak var delete: UIBarButtonItem!
    
    var petPhoto: String!
    var imageId: String!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.photo.sd_setImage(with: URL(string: petPhoto), placeholderImage: nil, options: [.continueInBackground, .progressiveDownload], completed: { (petPhoto, error, cacheType, URL) in
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        })
    }
    
    
    @IBAction func shareImage(_ sender: Any) {
        
        let activityViewController = UIActivityViewController(activityItems: [photo.image!], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    


    @IBAction func deleteImage(_ sender: Any) {
        
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to delete this photo?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            self.photo.isHidden = true
          
            // goes back to the gallery view controller
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
            
            DataService.ds.DB_BASE.child("photos").child(self.imageId).removeValue()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelled")
        }))
        
        present(alert, animated: true, completion: nil)
       
        
    }
    
   

}
