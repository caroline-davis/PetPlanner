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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photo.contentMode = .scaleAspectFit
        
        
    }
    
    func configure(petImage: PetImage) {
            self.photo.sd_setImage(with: URL(string: petImage.photo), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { (profilePic, error, cacheType, URL) in
            })
    }
}
