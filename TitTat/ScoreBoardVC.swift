//
//  ScoreBoardVC.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/19/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse

class ScoreBoardVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var otherUsers : [User] = []
    var tats : [Tat] = []
    var searchTats : [Tat] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tat = Tat()
        let user = PFUser.currentUser() as! User
        self.navigationController!.hidesBarsOnSwipe = true;
        
        
        tat.queryForTats(user, completionClosure: { (tats : [Tat]) -> () in
            self.searchTats = tats
            self.tableView.reloadData()
            println(self.searchTats)
        })
        
//        let queryForUsers = User.query()
//        queryForUsers?.findObjectsInBackgroundWithBlock({ (users, error) -> Void in
//            if error == nil
//            {
//                if let peopleArray = users as? [User]
//                {
//                    self.otherUsers = peopleArray
//                    self.tableView.reloadData()
//                }
//            }
//        })
        
//        var queryForTats = Tat.query()
//        if let queryForTats = queryForTats {
//            queryForTats.whereKey("giver", equalTo: PFUser.currentUser()!)
//            var query = PFQuery.orQueryWithSubqueries([queryForTats])
//            query.whereKey("taker", equalTo: PFUser.currentUser()!)
//            return query
//            
//        }
        
        
        
//        let queryForMyTats = Tat.query()
//        queryForMyTats?.whereKey("giver", equalTo: PFUser.currentUser()!)
//        let queryForMyTits = Tat.query()
//        queryForMyTits?.whereKey("taker", equalTo: PFUser.currentUser()!)
//        let compoundQuery = PFQuery.orQueryWithSubqueries([queryForMyTats!, queryForMyTits!])
//        compoundQuery.findObjectsInBackgroundWithBlock { (tatters, error) -> Void in
//            
//            self.tats = tatters as! [Tat]
//            self.tableView.reloadData()
//        }

    
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! UITableViewCell
        let userForRow = otherUsers[indexPath.row]
//        var tradeBalance = 0 as Int
        var numberGiven : [Tat] = []
        var numberTaken : [Tat] = []
        for tat in tats
        {
            if tat.giver == PFUser.currentUser() && tat.taker == userForRow
            {
                userForRow.deficit += 1
                numberGiven.append(tat)
            }
            else if tat.giver == userForRow && tat.taker == PFUser.currentUser()
            {
                userForRow.deficit += -1
                numberTaken.append(tat)
            }
        }
        
        var net = numberGiven.count - numberTaken.count
//        println(numberGiven.count)
//        println(numberTaken.count)
        if userForRow == PFUser.currentUser()
        {
            cell.backgroundColor = UIColor.blueColor()
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
        }
        cell.textLabel?.text = userForRow.username
        cell.detailTextLabel?.text = String(net)
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherUsers.count
    }
}
