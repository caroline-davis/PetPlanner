//
//  EventCell.swift
//  PetPlanner
//
//  Created by Caroline Davis on 12/7/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    // in the future we will also put an alarm here with a bool and do a push notification to the user when the event is near
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let theDate = dateFormatter.string(from: petEvent.eventDate)
        let theTime = timeFormatter.string(from: petEvent.eventDate)
        
        self.eventDate?.text = theDate
        self.eventTime?.text = theTime
        self.eventLocation?.text = petEvent.location.capitalized
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        
    }
}
