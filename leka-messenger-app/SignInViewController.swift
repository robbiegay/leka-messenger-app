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
import TinyConstraints

class SignInViewController: UIViewController {
    
    let segmented = UISegmentedControl()
    let username = UITextField()
    let password = UITextField()
    let confirmPassword = UITextField()
    let firstName = UITextField()
    let doneButton = UIButton()
    
    var viewType = "Log-in"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Leka App"
        view.backgroundColor = .white
        
        view.addSubview(segmented)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(confirmPassword)
        view.addSubview(firstName)
        view.addSubview(doneButton)
        
        segmented.topToSuperview(offset: 100)
        segmented.centerXToSuperview()
        segmented.insertSegment(withTitle: "Log-in", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Sign-up", at: 1, animated: true)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(handleViewType), for: .valueChanged)
        
        username.top(to: segmented, offset: 50)
        username.centerXToSuperview()
        username.placeholder = "username"
        username.autocapitalizationType = .none
        username.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        password.top(to: username, offset: 50)
        password.centerXToSuperview()
        password.placeholder = "password"
        password.isSecureTextEntry = true
        password.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        confirmPassword.top(to: password, offset: 50)
        confirmPassword.centerXToSuperview()
        confirmPassword.placeholder = "confirm password"
        confirmPassword.isSecureTextEntry = true
        confirmPassword.isHidden = true
        
        firstName.top(to: confirmPassword, offset: 50)
        firstName.centerXToSuperview()
        firstName.placeholder = "first name"
        firstName.isHidden = true
        
        doneButton.top(to: password, offset: 50)
        doneButton.centerXToSuperview()
        doneButton.height(30)
        doneButton.width(75)
        doneButton.setTitle("Log-in", for: .normal)
        doneButton.setTitleColor(.gray, for: .normal)
        doneButton.showsTouchWhenHighlighted = true
        doneButton.backgroundColor = #colorLiteral(red: 0.9332197309, green: 0.9333186746, blue: 0.9373039603, alpha: 1)
        doneButton.layer.borderWidth = 1
        doneButton.layer.cornerRadius = 15
        doneButton.layer.masksToBounds = true
        doneButton.addTarget(self, action: #selector(handleDone), for: .touchUpInside)
        doneButton.isEnabled = false
        
        
//        //    FirebaseApp.configure()
//        let authUI = FUIAuth.defaultAuthUI()
//        // You need to adopt a FUIAuthDelegate protocol to receive callback
//        authUI!.delegate = self as! FUIAuthDelegate
//
//        let providers: [FUIAuthProvider] = [
//          FUIGoogleAuth(),
//          FUIFacebookAuth(),
//          FUITwitterAuth(),
//          FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
//        ]
//        self.authUI.providers = providers
//
//        let authViewController = authUI.authViewController()
//
//        func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
//          // handle user and error as necessary
//        }

        // Do any additional setup after loading the view.
    }
    
    @objc func handleViewType() {
        if segmented.titleForSegment(at: segmented.selectedSegmentIndex)! == "Log-in" {
            viewType = "Log-in"
            confirmPassword.isHidden = true
            firstName.isHidden = true
            
            doneButton.removeFromSuperview()
            
            view.addSubview(doneButton)
            doneButton.top(to: password, offset: 50)
            doneButton.centerXToSuperview()
        } else if segmented.titleForSegment(at: segmented.selectedSegmentIndex)! == "Sign-up" {
            viewType = "Sign-up"
            confirmPassword.isHidden = false
            firstName.isHidden = false
            
            doneButton.removeFromSuperview()
            
            view.addSubview(doneButton)
            doneButton.top(to: firstName, offset: 50)
            doneButton.centerXToSuperview()
        } else {
            print("Error => Segmented control triggered default case")
        }
        print(viewType)
    }
    
    @objc func enableButton() {
        if username.text != "" && password.text != "" {
            doneButton.setTitleColor(.black, for: .normal)
            doneButton.isEnabled = true
        } else {
            doneButton.setTitleColor(.gray, for: .normal)
            doneButton.isEnabled = false
        }
    }
    
    @objc func handleDone() {
        if viewType == "Log-in" {
            print("LOG-IN:")
            print("Username: \(username.text!)")
            print("Password: \(password.text!)")
        } else if viewType == "Sign-up" {
            print("SIGN-UP")
            print("Username: \(username.text!)")
            print("Password: \(password.text!)")
            print("First name: \(firstName.text!)")
        }
        
    }
}

/*
 - Show way to confirm password
 */
