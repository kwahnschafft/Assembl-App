//
//  HomeModel.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 4/4/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import Foundation

protocol HomeModelProtocal: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    var hasLoggedInUser: Bool = false
    var currentUser: UserModel?
    
    func logInUser(user: UserModel){
        hasLoggedInUser = true
        currentUser = user
    }
    
    func logOutUser(){
        hasLoggedInUser = false
        currentUser = nil
    }
    
    //properties
    
    weak var delegate: HomeModelProtocal!
    
    var data : NSMutableData = NSMutableData()
    
    let urlPath: String = "http://vqq.bbo.mybluehost.me/service.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        var session: URLSession!
        let configuration = URLSessionConfiguration.default
        
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: url as URL)
        
        task.resume()
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Failed to download data")
            
        }else {
            print("Data downloaded")
            print(data)
            self.parseJSON()
        }
        
    }
    
    func parseJSON() {
        
        var jsonResult: NSArray = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: self.data as Data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement: NSDictionary = NSDictionary()
        let events: NSMutableArray = NSMutableArray()
        
        for i in 0..<jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let event = EventModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let name = jsonElement["Name"] as? String,
                let info = jsonElement["Info"] as? String
            {
                
                event.name = name
                event.info = info
                
            }
            
            events.add(event)
            
        }
        
        DispatchQueue.main.async {
            self.delegate.itemsDownloaded(items: events)
        }
    }
}
