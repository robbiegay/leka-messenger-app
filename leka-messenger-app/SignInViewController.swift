//
//  SignInViewController.swift
//  leka-messenger-app
//
//  Created by Robbie Gay on 2/16/20.
//  Copyright © 2020 robbiegay. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseUI
import TinyConstraints

class SignInViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    let segmented = UISegmentedControl()
    let email = UITextField()
    let password = UITextField()
    let confirmPassword = UITextField()
    let username = UITextField()
    let firstName = UITextField()
    let doneButton = UIButton()
    
    var viewType = "Log-in"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Leka App"
        view.backgroundColor = .white
        
        view.addSubview(segmented)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(confirmPassword)
        view.addSubview(username)
        view.addSubview(firstName)
        view.addSubview(doneButton)
        
        segmented.topToSuperview(offset: 100)
        segmented.centerXToSuperview()
        segmented.insertSegment(withTitle: "Log-in", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Sign-up", at: 1, animated: true)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(handleViewType), for: .valueChanged)
        
        email.top(to: segmented, offset: 50)
        email.centerXToSuperview()
        email.placeholder = "email"
        email.textAlignment = .center
        email.autocapitalizationType = .none
        email.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        password.top(to: email, offset: 50)
        password.centerXToSuperview()
        password.placeholder = "password"
        password.textAlignment = .center
        password.isSecureTextEntry = true
        password.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        confirmPassword.top(to: password, offset: 50)
        confirmPassword.centerXToSuperview()
        confirmPassword.placeholder = "confirm password"
        confirmPassword.textAlignment = .center
        confirmPassword.isSecureTextEntry = true
        confirmPassword.isHidden = true
        confirmPassword.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        username.top(to: confirmPassword, offset: 50)
        username.centerXToSuperview()
        username.placeholder = "username"
        username.textAlignment = .center
        username.autocapitalizationType = .none
        username.isHidden = true
        username.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
        firstName.top(to: username, offset: 50)
        firstName.centerXToSuperview()
        firstName.placeholder = "first name"
        firstName.textAlignment = .center
        firstName.isHidden = true
        firstName.addTarget(self, action: #selector(enableButton), for: .allEditingEvents)
        
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
//        authUI!.delegate = self
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
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @objc func handleViewType() {
        if segmented.titleForSegment(at: segmented.selectedSegmentIndex)! == "Log-in" {
            viewType = "Log-in"
            password.backgroundColor = .white
            confirmPassword.isHidden = true
            username.isHidden = true
            firstName.isHidden = true
            
            doneButton.removeFromSuperview()
            
            view.addSubview(doneButton)
            doneButton.top(to: password, offset: 50)
            doneButton.centerXToSuperview()
        } else if segmented.titleForSegment(at: segmented.selectedSegmentIndex)! == "Sign-up" {
            viewType = "Sign-up"
            confirmPassword.isHidden = false
            username.isHidden = false
            firstName.isHidden = false
            
            doneButton.removeFromSuperview()
            
            view.addSubview(doneButton)
            doneButton.top(to: firstName, offset: 50)
            doneButton.centerXToSuperview()
        } else {
            print("Error => Segmented control triggered default case")
        }
        print(viewType)
        enableButton()
    }
    
    @objc func enableButton() {
        if viewType == "Log-in" {
            if email.text != "" && password.text != "" {
                doneButton.setTitleColor(.black, for: .normal)
                doneButton.isEnabled = true
            } else {
                doneButton.setTitleColor(.gray, for: .normal)
                doneButton.isEnabled = false
            }
        } else if viewType == "Sign-up" {
            var passwordsMatch = false
            
            if password.text == "" {
                password.backgroundColor = .white
                confirmPassword.backgroundColor = .white
                passwordsMatch = false
            } else if password.text != confirmPassword.text && viewType == "Sign-up" {
                password.backgroundColor = #colorLiteral(red: 0.9813225865, green: 0.2694862527, blue: 0.2451137677, alpha: 1)
                confirmPassword.backgroundColor = #colorLiteral(red: 0.9813225865, green: 0.2694862527, blue: 0.2451137677, alpha: 1)
                doneButton.setTitleColor(.gray, for: .normal)
                passwordsMatch = false
            } else {
                password.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                confirmPassword.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                doneButton.setTitleColor(.black, for: .normal)
                passwordsMatch = true
            }
            
            if email.text != "" &&
                password.text != "" &&
                passwordsMatch == true &&
                username.text != "" &&
                firstName.text != "" {
                    doneButton.setTitleColor(.black, for: .normal)
                    doneButton.isEnabled = true
            } else {
                doneButton.setTitleColor(.gray, for: .normal)
                doneButton.isEnabled = false
            }
        }
    }
    
    @objc func handleDone() {
        if viewType == "Log-in" {
            print("LOG-IN:")
            print("Email: \(email.text!)")
            print("Password: \(password.text!)")
            
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
              // ...
            }
        } else if viewType == "Sign-up" {
            print("SIGN-UP")
            print("Email: \(email.text!)")
            print("Password: \(password.text!)")
            print("Username: \(username.text!)")
            print("First name: \(firstName.text!)")
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
              // ...
            }
        }
        
    }
}

/*
 - Set up Firebase auth
*/
