//
//  SignUpViewController.swift
//  Assembl
//
//  Created by Kelly on 4/1/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

class SignUpViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var alert: UIAlertController?
    var user: UserModel?
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Handle the text field’s user input through delegate callbacks
        usernameField.delegate = self
        passwordField.delegate = self
        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: sign up button stuff
    
    //disables the sign up button while entering info necessary?**
   // func textFieldDidBeginEditing(_ textField: UITextField) {
    //    print(" 1:\(signUpButton.isEnabled)")
     //   signUpButton.isEnabled = false
     //   print(" 2:\(signUpButton.isEnabled)")
    //}
    
    // Disable the  sign up button if the text field is empty
    private func updateSaveButtonState() {
        let text1 = usernameField.text ?? ""
        let text2 = passwordField.text ?? ""
        
        signUpButton.isEnabled = !(text1 == "" || text2 == "")
      //  print("text1: \(text1) Text2: \(text2) code: \(!(text1 == "" || text2 == "")) \(signUpButton.isEnabled)")
    }
    
    //enable sign up button when there is text
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }

    
    //MARK: Navigation
    
    // configure a view controller before it's presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed ***not working, is this necessary??
     //   guard let button = sender as? UIBarButtonItem, button === signUpButton else {
      //      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
       //     return
     //   }
        
        
        //Check input values
        
        
        //if theres a problem here, its probably because it goes to the rest of the method
        //to fix, add breaks ****
    
       guard let username = usernameField.text, username != "" else {
            self.alert = UIAlertController(title: "Invalid", message: "Username required", preferredStyle: .alert)
            self.present(alert!, animated: false, completion: nil)
            return
        }
    
        guard let password = passwordField.text, password != "" else {
            alert = UIAlertController(title: "Invalid", message: "Password required", preferredStyle: .alert)
            self.present(alert!, animated: false, completion: nil)
            return
        }
        
        
        
        //create user based on input
        //*** failable initializer??
        user = UserModel(username: username, password: password)
        
    }
    
    
 }



