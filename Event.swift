//
//  Event.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 5/3/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

class Event: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var info: String
    var photo: UIImage?
    var user: UserModel
    
    //MARK: Archiving Paths
    
    //directory where the app can save data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("events")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let info = "info"
        static let photo = "photo"
        static let user = "user"
    }
    
    //MARK: Initialization
    
    init?(name: String, info: String, photo: UIImage?, user: UserModel) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The description must not be empty
        guard !info.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.info = info
        self.photo = photo
        self.user = user
        
        /* Initialization should fail if there is no name or description
        if name.isEmpty || info.isEmpty  {
            return nil
        }*/
    
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(info, forKey: PropertyKey.info)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(user, forKey: PropertyKey.user)
    }
    
    //required: initalizer must be implemented in all subclasses
    //convenience: must call a designated initializer from the same class.
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for an Event object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because info is an optional property of Event, just use conditional cast.
        let info = aDecoder.decodeObject(forKey: PropertyKey.info) as? String

        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        // The name is required. If we cannot decode a user object, the initializer should fail.
        //let currentUser = loadCurrentUser()
            // Must call designated initializer.
        guard let user = Event.loadCurrentUser() else {
            return nil
        }
        
        self.init(name: name, info: info!, photo: photo, user: user)
    
    }
    
    class func loadCurrentUser() -> UserModel? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.CurrentUserArchiveURL.path) as? UserModel
    }
    
}
