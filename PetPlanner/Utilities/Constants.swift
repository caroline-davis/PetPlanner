//
//  Constants.swift
//  PetPlanner
//
//  Created by Caroline Davis on 23/1/18.
//  Copyright © 2018 Caroline Davis. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import SwiftKeychainWrapper


let KEY_UID = "uid"
var USER_ID = KeychainWrapper.standard.string(forKey: KEY_UID)!
let DEFAULT_PROFLE_IMAGE = "https://firebasestorage.googleapis.com/v0/b/petplanner252.appspot.com/o/pets%2Fprofile-picture.png?alt=media"
var CURRENT_PET_ID: String!


var ref: DatabaseReference!


// Colours
let WHITE_COLOR = UIColor.white
let PINK_COLOR = UIColor(red:0.73, green:0.35, blue:0.76, alpha:1.0)
let BLUE_COLOR = UIColor(red:0.25, green:0.22, blue:0.66, alpha:1.0)
let BLACK_COLOR = UIColor(red:0.09, green:0.09, blue:0.09, alpha:1.0)

