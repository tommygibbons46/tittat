//
//  ProfileViewController.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/20/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tatArray : [Tat] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        self.navigationController!.hidesBarsOnSwipe = true;

        let tatPull = Tat()
        if let user = PFUser.currentUser() as? User
        {
            println("cast")
            tatPull.queryForTats(user, completionClosure: { (tats) -> () in
                self.tatArray = tats
                self.tableView.reloadData()
            })
        }
        else
        {
            println("not cast")
        }
        
       
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
//        let feedIndex = indexPath.row - 1
        
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("profile") as! ProfileTableViewCell
            let user = PFUser.currentUser() as? User
            cell.nameLabel.text = user!.username
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellID")as! UITableViewCell
            
            var tat = self.tatArray[indexPath.row - 1] as Tat
            cell.textLabel?.text = tat.taker.username
            cell.detailTextLabel?.text = tat.message
            return cell
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = tatArray.count + 1
        return number
    }
    
    
}
