//
//  ConversationViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/17/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class SingleConversationViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
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
