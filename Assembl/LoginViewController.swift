//
//  LoginViewController.swift
//  Assembl
//
//  Created by Kelly on 4/1/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // to be connected to x button on login screen ****
    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        //var alert: UIAlertController
        
        // check if fields are full
        guard let username = self.usernameField.text, !username.isEmpty else {
           // alert = UIAlertController(title: "Invalid", message: "Username required", preferredStyle: .alert)
           // alert.present(alert, animated: false, completion: nil)
            return
        }
        guard let password = self.passwordField.text, !password.isEmpty else {
          //  alert = UIAlertController(title: "Invalid", message: "Password required", preferredStyle: .alert)
          //  alert.present(alert, animated: false, completion: nil)
            return
        }
         //   // Run a spinner to show a task in progress
         //   var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
         //   spinner.startAnimating()
            
            // Send a request to login
        
        //Log user in
        do {
            try UserProvider.loginUser(name: username, password: password)
        } catch UserError.invalidUser {
          //  alert = UIAlertController(title: "Invalid", message: "User with this name does not exist", preferredStyle: .alert)
           // alert.present(alert, animated: false, completion: nil)
            return
        }
        catch UserError.incorrectPassword {
          //  alert = UIAlertController(title: "Invalid", message: "Username and password do not match", preferredStyle: .alert)
          //  alert.present(alert, animated: false, completion: nil)
            return
        }
        
                
                // Stop the spinner
          //      spinner.stopAnimating()
                
          //      if ((user) != nil) {
           //         var alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
            //        alert.show()
                    
            //        dispatch_async(dispatch_get_main_queue(), { () -> Void in
             //           let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
               //         self.presentViewController(viewController, animated: true, completion: nil)
                //    })
                    
              //  } else {
              //      var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                //    alert.show()
         //       }
          //  })
   //     }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*
     enum UserError: String, Error {
     case invalidUser
     case incorrectPassword
     case preexistingUser
     }
     
     func loginUser(name: String, password: String) throws UserError{ 
        guard let user = usersList.getUser(name: name), user != null else{
            throw UserError.invalidUser
        }
        if user.getPassword() != password {
            throw UserError.incorrectPassword
        }
        else {
            currentUser = user
            isLoggedIn = true
            // go to other page ****
        }
     
     }
     
     func addUser(user: user) throws UserError{
        guard let user = usersList.getUser(name: name), user == null else{
            throw UserError.preexistingUser
        }
        else {
            // add user to usersList
        }
     
    */
}
