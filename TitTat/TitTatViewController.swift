//
//  TitTatViewController.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/20/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse

class TitTatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var userToTransactWith : User?
    
    var searchResults : [User] = []
    var filteredResults : [User] = []

    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTextField: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hidden = true
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func giveFavor(sender: AnyObject) {
        
        let tat = Tat()
        let currentUser = (PFUser.currentUser() as? User)!
        currentUser.incrementKey("tatScore", byAmount: 1)
        tat.giver = currentUser
//        tat.message = "cooking me dinner"
        let query = User.query()
        tat.giver = userToTransactWith!
        tat.saveInBackgroundWithBlock { (success, error) -> Void in
            if error == nil
            {
                //call funcitons in cloud to update scores i think
            }
        }
        
    }

    @IBAction func takeFavor(sender: AnyObject) {
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let text = textField.text.lowercaseString
        println(text)
        if count(text) == 0
        {
            tableView.hidden = false
            println("in here")
            let text = textField.text
            println(text)
            let userQueryForFirstName = User.query()
            //        userQueryForFirstName?.whereKey("firstName", containsString: text)
            //        let userQueryForUserName = User.query()
            //        userQueryForUserName?.whereKey("username", containsString: text)
            
            //        let compoundSearchQuery = PFQuery.orQueryWithSubqueries([userQueryForUserName!, userQueryForFirstName!])
            userQueryForFirstName!.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
                if error == nil
                {
                    if let searchArray = results as? [User]
                    {
                        self.searchResults = searchArray
                        self.tableView.reloadData()
                        println(self.searchResults)
                    }
                }
            })
        }
        else
        {
            searchArray(text)
        }
        return true
        
    }
    
    func searchArray(withText: String)
    {
        filteredResults = []
        for x in self.searchResults
        {
            if x.username?.lowercaseString.rangeOfString(withText) != nil || x.firstName.lowercaseString.rangeOfString(withText) != nil
            {
//                println(x)
                println("got here")
                filteredResults.append(x)
                
                //we need to wipe the array an add it to the new one
            }
        }
        self.tableView.reloadData()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
//        tableView.hidden = false
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID") as! UITableViewCell
        var userForRow = filteredResults[indexPath.row] as User
        cell.textLabel?.text = userForRow.username
        cell.detailTextLabel?.text = userForRow.firstName
        return cell
        
    }


}
