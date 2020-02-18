//
//  MessageThreadsViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/17/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AllConversationsViewController: UITableViewController {

    var handle: AuthStateDidChangeListenerHandle?
    let db = Firestore.firestore()
    
    var userEmail = Auth.auth().currentUser?.email
    
    var conversations: [Any] = []
    var messages: [Any] = []
    var username = ""
    var numOfRows = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Nav Bar
        navigationItem.title = "Conversations"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign-out", style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "newMessage"), style: .plain, target: self, action: #selector(handleNewMessage))
                
        db.collection("users").document(userEmail!).collection("conversations").getDocuments() { (QuerySnapshot, err) in
            if let error = err {
                print("Error =>", error)
            } else {
                for document in QuerySnapshot!.documents {
                    self.numOfRows += 1
                    self.conversations.append(document.documentID)
                    self.messages.append(document.data())
                }
                self.tableView.reloadData()
            }
        }
        
        let data = db.collection("users").document(userEmail!).getDocument { (document, error) in
            self.username = document?.data()!["username"] as! String
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = conversations[indexPath.row] as? String
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleConversationVC = SingleConversationViewController()
        let user = username
        let partner = conversations[indexPath.row] as! String
        let messagesData = messages[indexPath.row]
        singleConversationVC.populate(user: user, partner: partner, messages: messagesData)
        
        navigationController?.pushViewController(singleConversationVC, animated: true)
    }
    
    @objc func handleSignOut() {
        do {
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    @objc func handleNewMessage() {
        navigationController?.present(NewConversationViewController(), animated: true, completion: nil)
    }
}

/*
 - If no feeds -> present new message screen
 - figure out logic of creating cells from db
 */
