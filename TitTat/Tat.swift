//
//  Tat.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/16/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse

class Tat: PFObject, PFSubclassing

{
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Tat"
    }
    
    @NSManaged var giver : User
    @NSManaged var taker : User
    @NSManaged var message : String
    
    func queryForTats(user: User, completionClosure:(tats: [Tat])->())
    {
        let queryForMyTats = Tat.query()
        queryForMyTats?.whereKey("giver", equalTo: PFUser.currentUser()!)
        let queryForMyTits = Tat.query()
        queryForMyTits?.whereKey("taker", equalTo: PFUser.currentUser()!)
        let compoundQuery = PFQuery.orQueryWithSubqueries([queryForMyTats!, queryForMyTits!])
        compoundQuery.includeKey("taker")
        compoundQuery.includeKey("giver")
        compoundQuery.findObjectsInBackgroundWithBlock { (tatters, error) -> Void in
            
            var tats = tatters as! [Tat]
            completionClosure(tats: tats)
        }
    }
//    func queryForTats2(user: User){(tats: [Tat]))
//        let queryForMyTats = Tat.query()
//        queryForMyTats?.whereKey("giver", equalTo: PFUser.currentUser()!)
//        let queryForMyTits = Tat.query()
//        queryForMyTits?.whereKey("taker", equalTo: PFUser.currentUser()!)
//        let compoundQuery = PFQuery.orQueryWithSubqueries([queryForMyTats!, queryForMyTits!])
//        compoundQuery.findObjectsInBackgroundWithBlock { (tatters, error) -> Void in
//            
//            var tats = tatters as! [Tat]
//            tats
//        }
//    }
    
   
}
