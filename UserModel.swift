//
//  UserModel.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 4/4/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import Foundation
import os.log
import UIKit


enum UserError: String, Error {
    case databaseError
}

class UserModel: NSObject, NSCoding {
    
    //MARK: Properties
    
    var username: String?
    var password: String?
    var email: String?
    var events: [String]
    
    var alert: UIAlertController?
    
    
    struct PropertyKey {
        static let username = "username"
        static let password = "password"
        static let events = [String]()
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("users")
    
    //empty constructor
    
    /* override init()
    {
        
    } */
    
    //construct with @name, @info
    
    init?(username: String, password: String) {
        
        self.username = username
        self.password = password
        self.events = [String]()
        self.alert = nil
        
        // Initialization should fail if username or password are are too short of if username is already taken
        // Validate the text fields **** make switch statement?
        
        //Username
        if username.characters.count < 5 {
            //**** cancelButtonTitle?
            alert = UIAlertController(title: "Invalid", message: "Username must be greater than 5 characters", preferredStyle: .alert)
            alert!.present(alert!, animated: false, completion: nil)
            return nil
        }
            /* else if UserProvider.containsUser(name: username) {
             var alert = UIAlertController(title: "Invalid", message: "A user with this name already exists", preferredStyle: .alert)
             alert!.present(alert, animated: false, completion: nil)
             return nil
             }*/
            
            //Password
        else if password.characters.count < 8 {
            alert = UIAlertController(title: "Invalid", message: "Passwords must be greater than 8 characters", preferredStyle: .alert)
            alert!.present(alert!, animated: false, completion: nil)
            return nil
        }
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Username: \(username), Password: \(password)" //user for debugging, shouldn't be able to print password
        
    }
    
    /*
    // called when a user successfully completetes the sign up form
    func signUp() throws {
        do{
            try self.saveToDatabase()
     //       HomeModel.logInUser(self)
        } catch UserError.databaseError{
            throw UserError.databaseError
        }
        
    }
    
    
    // adds a user's info to the database
    func saveToDatabase(){
        
    }*/
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: PropertyKey.username)
        aCoder.encode(password, forKey: PropertyKey.password)
        aCoder.encode(events, forKey: PropertyKey.events.joined(separator: "-"))
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let username = aDecoder.decodeObject(forKey: PropertyKey.username) as? String else {
            os_log("Unable to decode the username for a User object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let password = aDecoder.decodeObject(forKey: PropertyKey.password) as? String else {
            os_log("Unable to decode the password for a User object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let events = aDecoder.decodeObject(forKey: PropertyKey.events.joined(separator: "-")) as? [String] else {
            os_log("Unable to decode the events for a User object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(username: username, password: password)
    }
    
}
