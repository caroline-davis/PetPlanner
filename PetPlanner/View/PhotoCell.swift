//
//  PhotoCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 30/4/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//


import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photo.contentMode = .scaleAspectFill
        
    }
    
    // To Do : Add placeholder image
    
    func configure(petImage: PetImage) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
            self.photo.sd_setImage(with: URL(string: petImage.photo), placeholderImage: nil, options: [.continueInBackground, .scaleDownLargeImages], completed: { (profilePic, error, cacheType, URL) in
                
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            })
    }
    
    func img(collectionView: UICollectionView) {
        // Set up Collection View
        let width = photo.frame.size.width
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width:width, height:width)
    }
}


