//
//  ViewController.swift
//  TitTat
//
//  Created by Thomas Gibbons on 8/16/15.
//  Copyright (c) 2015 Thomas Gibbons. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newUser = User();

    }
    
    @IBAction func logInButton(sender: AnyObject)
    {
        let alertView = UIAlertController(title: "log in", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "log in"
        }
        alertView.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "password"
        }
        alertView.addAction(UIAlertAction(title: "log in", style: .Default, handler: { (action1) -> Void in
            //sign up
            let userNameTextfield = alertView.textFields![0] as! UITextField
            let passwordTextField = alertView.textFields![1] as! UITextField
            PFUser.logInWithUsernameInBackground(userNameTextfield.text, password: passwordTextField.text, block: { (user, error) -> Void in
                if let user = PFUser.currentUser() as? User
                {
                    println(user)
                    self.performSegueWithIdentifier("profile", sender: nil)
                    Mixpanel.sharedInstanceWithToken("27db6b69769b8e1c05b7b19ee4e76644")
                    let mixpanel: Mixpanel = Mixpanel.sharedInstance()
                    mixpanel.track("Logged In")
                }
                
//                self.performSegueWithIdentifier("toScoreboard", sender: nil)
            })
        }))
        alertView.addAction(UIAlertAction(title: "close", style: .Default, handler: { (action2) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    @IBAction func createTit(sender: AnyObject) {
        
        ///question now is we are incrememnting generic tats, but we needd to know the relationship tats...we could just query all tats where the giver is the other person....wouldn't be too hard
        
    }

    @IBAction func createTat(sender: AnyObject)
    {
        let tat = Tat()
        let currentUser = (PFUser.currentUser() as? User)!
        currentUser.incrementKey("tatScore", byAmount: -1)
        tat.taker = currentUser
        tat.message = "cooking me dinner"
        let query = User.query()
        query?.getObjectInBackgroundWithId("BM4bLayjhO", block: { (user, error) -> Void in
            
            if let user = user as? User
            {
                tat.giver = user
                let stringID = user.objectId as String!
                tat.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success
                    {
                        PFCloud.callFunctionInBackground("updateOtherUser", withParameters: ["stringID" : stringID], block: { (results, error) -> Void in
                            if error == nil
                            {
                                println("Well that worked, user incremented")
                                println(results)
                                println(error)
                            }
                        })
            
                        currentUser.saveInBackgroundWithBlock({ (success, error) -> Void in
                            if success
                            {
                                println("current user decremented")
                            }
                            
                        })
                    }
                })
            }
            
        })
    }
   


}

