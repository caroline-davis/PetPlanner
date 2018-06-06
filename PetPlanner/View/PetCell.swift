//
//  PetCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/2/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    

    @IBOutlet weak var profilePic: CircularImgView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var species: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var idTag: UILabel!
    
    @IBOutlet weak var editCell: UIButton!
    @IBOutlet weak var deleteCell: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
     //   if self.contentView.backgroundColor == PINK_COLOR {
            name.textColor = WHITE_COLOR
            species.textColor = WHITE_COLOR
            dob.textColor = WHITE_COLOR
            sex.textColor = WHITE_COLOR
            idTag.textColor = WHITE_COLOR
//        } else {
//            name.textColor = BLUE_COLOR
//            species.textColor = BLUE_COLOR
//            dob.textColor = BLUE_COLOR
//            sex.textColor = BLUE_COLOR
//            idTag.textColor = BLUE_COLOR
//        }
        
        
        
       
    }
    


    func configure(pet: PetProfile) {
  
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        self.name?.text = pet.name.capitalized
        self.dob?.text = "D.O.B: \(pet.dob.capitalized)"
        self.species?.text = "SPECIES: \(pet.species.capitalized)"
        self.sex?.text = "SEX: \(pet.sex.capitalized)"
        self.idTag?.text = "I.D: \(pet.idTag.capitalized)"
        
        self.profilePic.sd_setImage(with: URL(string: pet.profileImage), placeholderImage: #imageLiteral(resourceName: "ProfilePicturev3"), options: [.continueInBackground, .progressiveDownload], completed: { (profilePic, error, cacheType, URL) in
            
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
     //   contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
    }
    
    
}

