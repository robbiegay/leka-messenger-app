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
    var authors: [String] = []
    var dates: [String] = []
    
    let typeZone = UITextField()
    
    func populate(user:String, partner:String, messages:Any) {
        navigationItem.title = partner
        
        conversationOwner = user
        conversationWith = partner
        messagesData = messages as! [String:Any]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(typeZone)
        typeZone.topToSuperview(offset: 700)
        typeZone.leadingToSuperview()
        typeZone.borderStyle = .line
        typeZone.layer.borderWidth = 3
        typeZone.width(view.frame.width)
        typeZone.height(50)
        typeZone.placeholder = "Type here"
        
        for (key, value) in messagesData {
            if let data = value as? [String:Any] {
                messages.append(data["body"] as! String)
                authors.append(data["author"] as! String)
                print(type(of: data["date"]))
                let date = Date()
                print(date)
                dates.append(date.description)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let idx = indexPath.row
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.text = "\(authors[idx]):\n\(messages[idx])\n\(dates[idx])"
        if authors[idx] == conversationOwner {
            cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
//            cell.indentationLevel = 10
        } else {
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
        return cell
    }
}

/*
 - populate tableview with messages in the feed
 - Sort messages by date
 - send view of screen to bottom
 - ---> create a way to type a message (screen should move up on keyborad)
 - ---> create a way to send that message to the database (might need to create a model file)
 - create a way to update the messages
 - Create a "unread message" icon (and figure out how to make it "read"
 - Add this message feature to the new conversation page
 - soft message in AllConversations by most recent (general messages would need to be softed in this manner too)
 */
