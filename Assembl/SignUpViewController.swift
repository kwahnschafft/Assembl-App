//
//  SignUpViewController.swift
//  Assembl
//
//  Created by Kelly on 4/1/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

var currentUser = UserModel(username: "", password: "", events: [String]())

class SignUpViewController: UIViewController, UITextFieldDelegate   {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    // var alert: UIAlertController?
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
        
        let button2 = sender as! UIButton
        let buttonTitle = button2.title(for: .normal)
        // Configure the destination view controller only when the save button is pressed ***not working, is this necessary??
        if buttonTitle != "Sign up" {
            os_log("The sign up button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        
        //Check input values
        
        
        //if theres a problem here, its probably because it goes to the rest of the method
        //to fix, add breaks ****
        
        guard let username = usernameField.text, username != "" else {
            //     self.alert = UIAlertController(title: "Invalid", message: "Username required", preferredStyle: .alert)
            //   let alertCancelAction=UIAlertAction(title:"Cancel", style: UIAlertActionStyle.destructive,handler: { action in
            //     print("Cancel Button Pressed")
            // })
            // self.alert!.addAction(alertCancelAction)
            //      self.present(alert!, animated: false, completion: nil)
            return
        }
        
        guard let password = passwordField.text, password != "" else {
            //    alert = UIAlertController(title: "Invalid", message: "Password required", preferredStyle: .alert)
            //   let alertCancelAction=UIAlertAction(title:"Cancel", style: UIAlertActionStyle.destructive,handler: { action in
            //    print("Cancel Button Pressed")
            // })
            //  self.alert!.addAction(alertCancelAction)
            
            // self.present(alert!, animated: false, completion: nil)
            return
        }
        
        
        
        //create user based on input
        //*** failable initializer??
        user = UserModel(username: username, password: password, events: [String]())
    
        
        currentUser = user
        saveCurrentUser()
        users.append(user!)
        saveUsers()
        
    }
    
    private func saveUsers() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(users, toFile: UserModel.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Users successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save users...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadUsers() -> [UserModel]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.ArchiveURL.path) as? [UserModel]
    }
    
    private func saveCurrentUser() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(currentUser, toFile: UserModel.CurrentUserArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Current user successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save current user...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadCurrentUser() -> UserModel? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.CurrentUserArchiveURL.path) as? UserModel
    }
    
}



