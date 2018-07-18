//
//  EventCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var profilePic: CircularImgView!
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventName.textColor = WHITE_COLOR
        eventDate.textColor = WHITE_COLOR
        eventTime.textColor = WHITE_COLOR
        eventLocation.textColor = WHITE_COLOR
   
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
