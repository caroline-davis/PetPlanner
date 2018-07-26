//
//  EventCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    // we need to get the petid and fill in all the info for the current pet from EVENTS
    // we need to also get the petid and get the string to put the image for the profile picture
    
    // in the future we will get all the petIds associated with 1 userID and also put them here
    // we will also put an alarm here with a bool and do a push notification to the user when the event is near


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
    
    func configure(petEvent: PetEvents) {
        self.eventName?.text = petEvent.name.capitalized
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ssZZZZZ"

        
        self.eventDate?.text = dateFormatter.string(from: petEvent.date)
        self.eventTime?.text = timeFormatter.string(from: petEvent.date)
        self.eventLocation?.text = petEvent.location.capitalized
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
