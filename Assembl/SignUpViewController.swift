//
//  SignUpViewController.swift
//  Assembl
//
//  Created by Kelly on 4/1/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

class SignUpViewController: UIViewController {
    
    //@IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signUpAction(sender: AnyObject) {
        var alert: UIAlertController
        
        //if theres a problem here, its probably because it goes to the rest of the method
        //to fix, add breaks ****
        guard let username = self.usernameField.text, !username.isEmpty else {
            alert = UIAlertController(title: "Invalid", message: "Username required", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            return
        }
        guard let password = self.passwordField.text, !password.isEmpty else {
            alert = UIAlertController(title: "Invalid", message: "Password required", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            return
        }
        // should emails be optional? ****
        /*guard let email = self.emailField.text, !email.isEmpty else {
            alert = UIAlertController(title: "Invalid", message: "Email required", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            return
        } */
        
    //@IBAction func loginAction(sender: AnyObject) {
            
        }

     //****   var finalEmail = email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        
        // Validate the text fields **** make switch statement?
        
        //Username
       /* if username.characters.count < 5 {
            //**** cancelButtonTitle?
            alert = UIAlertController(title: "Invalid", message: "Username must be greater than 5 characters", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            
        } else if UserProvider.containsUser(name: username) {
            var alert = UIAlertController(title: "Invalid", message: "A user with this name already exists", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
        }
 
        //Password
        else if password.characters.count < 8 {
            alert = UIAlertController(title: "Invalid", message: "Passwords must be greater than 8 characters", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            
        }
        
        //Email
        else if email.characters.count < 8 { // umm no ****
            alert = UIAlertController(title: "Invalid", message: "Please enter a valid email address", preferredStyle: .alert)
            alert.present(alert, animated: false, completion: nil)
            
        } else {
            // Run a spinner to show a task in progress
           // var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            //spinner.startAnimating()
            
            //**** finalEmail
            var newUser = UserModel(username: username, password: password, email: email)
            
            // newUser.email = finalEmail **** do something with email?
            
            // Sign up the user asynchronously
            
            do {
                try UserProvider.addUser(user: newUser)
                try UserProvider.loginUser(user: newUser, password: newUser.getPassword()) //make current user and make logged in = true ****
            }catch UserError.preexistingUser{
                alert = UIAlertController(title: "Invalid", message: "A user witht this name already exists", preferredStyle: .alert)
                alert.present(alert, animated: false, completion: nil)
            } // these errors should never happen here hopefully******
            catch UserError.invalidUser {
                alert = UIAlertController(title: "Invalid", message: "User with this name does not exist", preferredStyle: .alert)
                alert.present(alert, animated: false, completion: nil)
                return
            } catch UserError.incorrectPassword {
                alert = UIAlertController(title: "Invalid", message: "Username and password do not match", preferredStyle: .alert)
                alert.present(alert, animated: false, completion: nil)
                return
            }

            
            //go to events page ****
            
            
            
            //**** old sign up stuff
        /*    newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner ****
            //    spinner.stopAnimating()
                if ((error) != nil) {
                    var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    var alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            }) */ */ */ */ */
            
            /*
            
            //MARK: Navigation
            
            // configure a view controller before it's presented
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                super.prepare(for: segue, sender: sender)
                
                // Configure the destination view controller only when the save button is pressed
                guard let button = sender as? UIBarButtonItem, button === saveButton else {
                    os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
                    return
                }

            } */
            
            

        /*
                
                // Verifying fields
    
                var alert: UIAlertController
                
                //if theres a problem here, its probably because it goes to the rest of the method
                //to fix, add breaks ****
                guard let username = self.usernameField.text, !username.isEmpty else {
                    alert = UIAlertController(title: "Invalid", message: "Username required", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                    return
                }
                guard let password = self.passwordField.text, !password.isEmpty else {
                    alert = UIAlertController(title: "Invalid", message: "Password required", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                    return
                }
                
                // should emails be optional? ****
                /*guard let email = self.emailField.text, !email.isEmpty else {
                 alert = UIAlertController(title: "Invalid", message: "Email required", preferredStyle: .alert)
                 alert.present(alert, animated: false, completion: nil)
                 return
                 } */
                
                
                // Validate the text fields **** make switch statement?

                //Username
                if username.characters.count < 5 {
                 //**** cancelButtonTitle?
                    alert = UIAlertController(title: "Invalid", message: "Username must be greater than 5 characters", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                 
                 } else if UserProvider.containsUser(name: username) {
                    alert = UIAlertController(title: "Invalid", message: "A user with this name already exists", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                }
                 
                 //Password
                 else if password.characters.count < 8 {
                    alert = UIAlertController(title: "Invalid", message: "Passwords must be greater than 8 characters", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                 
                 }
                 
                 //Email
                 else if email.characters.count < 8 { // umm no ****
                    alert = UIAlertController(title: "Invalid", message: "Please enter a valid email address", preferredStyle: .alert)
                    alert.present(alert, animated: false, completion: nil)
                 
                 }
                
                //make user with given input 
                user = UserModel(username: username, password: password, email: email)
                
 
            }
 
 */ */

        }


