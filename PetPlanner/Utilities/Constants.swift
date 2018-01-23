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
var CURRENT_USER = KeychainWrapper.standard.string(forKey: KEY_UID)!

var ref: DatabaseReference!
