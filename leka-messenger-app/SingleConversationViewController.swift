//
//  ConversationViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/17/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class SingleConversationViewController: UITableViewController {
    var conversationOwner = ""
    var conversationWith = ""
    var messagesData: [String:Any] = [:]
    var messages: [String] = []
    
    func populate(user:String, partner:String, messages:Any) {
        navigationItem.title = partner
        
        conversationOwner = user
        conversationWith = partner
        messagesData = messages as! [String:Any]
        print("user =>",conversationOwner)
        print("partner =>",conversationWith)
        print("messages =>",messagesData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (key, value) in messagesData {
            if let data = value as? [String:Any] {
                messages.append(data["body"] as! String)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
}

/*
 - Make nav bar title the persons name
 - populate tableview with messages in the feed
 - send view of screen to bottom
 - create a way to type a message (screen should move up on keyborad)
 - create a way to send that message to the database (might need to create a model file)
 - create a way to update the messages
 - Create a "unread message" icon (and figure out how to make it "read"
 - Add this message feature to the new conversation page
 - soft message in AllConversations by most recent (general messages would need to be softed in this manner too)
 */
