//
//  AllEventsTableViewController.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 5/18/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit

class AllEventsTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var myEvents = [Event]()
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        if let savedEvents = loadEvents() {
            events += savedEvents
        } else {
            //d
        }
        
        if let currentUser = loadCurrentUser() {
            var namesOfEvents = currentUser.events
            for event in events {
                if namesOfEvents.contains(event.name) {
                    myEvents.add(event)
                }
            }
        } else {
            //asdfalsdkfjs
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allEvents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventsTableViewCell.")
        }
        
        // Fetches the appropriate event for the data source layout.
        let event = myEvents[indexPath.row]
        
        
        cell.nameLabel.text = event.name
        cell.nameLabel.text = event.info
        cell.photoImageView.image = event.photo
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Private Methods
    
    private func loadAllEvents() {
        
        let photo1 = UIImage(named: "fut")
        let photo2 = UIImage(named: "me")
        let photo3 = UIImage(named: "comp")
        
        let user1 = UserModel(username: "kwahn", password: "hey", events: [String]())
        let user2 = UserModel(username: "kel", password: "yoyo", events: [String]())
        
        guard let event1 = Event(name: "Women's March", info: "yo",photo: photo1, user: user1) else {
            fatalError("Unable to instantiate event1")
        }
        
        guard let event2 = Event(name: "Men's March", info: "bye",photo: photo2, user: user1) else {
            fatalError("Unable to instantiate event2")
        }
        
        guard let event3 = Event(name: "Dog's March", info: "what",photo: photo3, user: user2) else {
            fatalError("Unable to instantiate event3")
        }
        
        allEvents += [event1, event2, event3]
    }
    
    private func loadCurrentUser() -> UserModel? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.ArchiveURL.path) as? UserModel
    }
    
    //unarchive the object stored at the path Event.ArchiveURL.path and downcast that object to an array of Event objects.
    private func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
    }
}
