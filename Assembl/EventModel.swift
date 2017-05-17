//
//  EventModel.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 4/4/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import Foundation

class EventModel: NSObject {
    
    //properties
    
    var name: String?
    var info: String?
    var creator: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @name, @info
    
    init(name: String, info: String, creator: String) {
        
        self.creator = creator
        self.name = name
        self.info = info
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "Name: \(name), Info: \(info), Creator: \(creator)"
        
    }
    
    
}
