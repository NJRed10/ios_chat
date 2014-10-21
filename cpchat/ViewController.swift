//
//  ViewController.swift
//  cpchat
//
//  Created by Niaz Jalal on 9/29/14.
//  Copyright (c) 2014 Niaz Nabib. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        var username = self.userNameTextField.text
        var password = self.passwordTextField.text
        PFUser.logInWithUsernameInBackground(username, password: password) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                //DO Segue shit here.
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
                // The login failed. Check error to see why.
            }
        }
        println("Sign In")
    }
    
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        var username = self.userNameTextField.text
        var password = self.passwordTextField.text
        var user = PFUser()
        user.username = username
        user.password = password
    //    user.email = ""
        // other fields can be set just like with PFObject
    //    user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                //GOTO Chat View Controller
                println("Going to chat view controller")
                self.performSegueWithIdentifier("chatSegue", sender: self)
            } else {
               // let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            }
        }
        println("Sign Up")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

