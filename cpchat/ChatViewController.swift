//
//  ChatViewController.swift
//  cpchat
//
//  Created by Niaz Jalal on 9/29/14.
//  Copyright (c) 2014 Niaz Nabib. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages: [Message] = [Message]()

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        
        println("We are in chat window")
        
        self.chatTableView.reloadData()

        // Do any additional setup after loading the view.
        
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSendButton(sender: AnyObject) {
        
        var message = PFObject(className:"Message")
        message["text"] = self.messageTextField.text
        message.saveInBackgroundWithBlock { (saved: Bool, error: NSError!) -> Void in
            
            if saved {
                println("saved message")
            } else {
                println("did not save message")
            }
            
            if error != nil {
                println("error occcurred")
            }
        }
    }
    
    func onTimer() {
        
        //NEED Parse retrieve
        var query = PFQuery(className:"Message")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
            // The find succeeded.
            NSLog("Successfully retrieved \(objects.count) scores.")
            // Do something with the found objects
            for object in objects {
                NSLog("%@", object.objectId)
                
                var message = object as Message
                self.messages.append(message)
            }
             self.chatTableView.reloadData()
        } else {
            // Log details of the failure
            NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        self.chatTableView.reloadData()

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count ?? 0
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = self.chatTableView.dequeueReusableCellWithIdentifier("MessageCell") as? MessageCell
        
        var message = self.messages[indexPath.row] as Message
        
        cell!.messageText.text = message.text
        
        return cell!
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
