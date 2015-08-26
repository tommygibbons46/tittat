//
//  User.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/16/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse


class User: PFUser, PFSubclassing
{

    override class func initialize() {
        self.registerSubclass()
    }
    
    @NSManaged var firstName : String
    @NSManaged var tatScore : NSNumber
    @NSManaged var deficit : Int
    @NSManaged var profilePicture : UIImage
}
