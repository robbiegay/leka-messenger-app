//
//  MessageThreadsViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/17/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessageThreadsViewController: UITableViewController {

    var handle: AuthStateDidChangeListenerHandle?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Message Feed"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "signout", style: .plain, target: self, action: #selector(handleSignOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "newMessage"), style: .plain, target: self, action: #selector(handleNewMessage))
    }
    
    //target: self, action: #selector(handleSignOut)
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("--> user logged in <--")
                print(user.uid)
                print(user.email)
                print("------------------------")
            }
        }
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
        print("New message")
    }
}

/*
 - If no feeds -> present new message screen
 */
