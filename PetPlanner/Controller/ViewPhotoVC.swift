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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
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
    }
    

}
