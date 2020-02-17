//
//  NewMessageViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/17/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit

class NewMessageViewController: UITableViewController {
    
//    let navBar = UINavigationController()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Message"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "new message"
        return cell
    }
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
}
