//
//  SignInViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/16/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //    FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI!.delegate = self as! FUIAuthDelegate
        
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth(),
          FUIFacebookAuth(),
          FUITwitterAuth(),
          FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
        ]
        self.authUI.providers = providers
        
        let authViewController = authUI.authViewController()
        
        func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
          // handle user and error as necessary
        }

        // Do any additional setup after loading the view.
    }

}
