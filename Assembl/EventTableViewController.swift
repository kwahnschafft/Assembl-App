//
//  EventTableViewController.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 5/6/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

//MARK: Properties

var events = [Event]()
var users = [UserModel]()

class EventTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*// Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem */
        
        // Load any saved events, otherwise load sample data.
        if let savedEvents = loadEvents() {
            events += savedEvents
        } else {
            //Load sample data
            loadSampleEvents()
        }
        
        //Load the saved
        if let savedUsers = loadUsers() {
            users += savedUsers
        } else {
            users += []
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        
        // Fetches the appropriate event for the data source layout.
        let event = events[indexPath.row]
        
        cell.nameLabel.text = event.name
        cell.infoLabel.text = event.info
        cell.photoImageView.image = event.photo
        
        return cell
    }
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
     }
    
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            saveEvents()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
     }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //possible segues and what to do when they are triggered
        switch(segue.identifier ?? "") {
            case "AddItem":
                os_log("Adding a new event.", log: OSLog.default, type: .debug)
            case "ShowDetail":
                guard let eventDetailViewController = segue.destination as? SecondViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedEventCell = sender as? EventTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedEventCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
            
                let selectedEvent = events[indexPath.row]
                eventDetailViewController.event = selectedEvent
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func unwindToEventList(sender: UIStoryboardSegue) {
    
        
        if let sourceViewController = sender.source as? SecondViewController, let event = sourceViewController.event {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing event.
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new event.
                let newIndexPath = IndexPath(row: events.count, section: 0)
                
                events.append(event)
                
                //animate the addition of a row to the table view containing this new event
                //(.automatic chooses the best animation based on the current table)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            // Save the events.
            saveEvents()
            
        }
        
        else if let sourceViewController = sender.source as? SignUpViewController, let user = sourceViewController.user {
            //add a new user
            users.append(user)
            saveUsers()
        
        }
        
    }
    
    //MARK: Private Methods
    
    private func loadSampleEvents() {
        let photo1 = UIImage(named: "fut")
        let photo2 = UIImage(named: "me")
        let photo3 = UIImage(named: "comp")
        
        let user1 = UserModel(username: "kwahn", password: "hey", events: [String]())
        let user2 = UserModel(username: "kel", password: "yoyo", events: [String]())
        
        guard let event1 = Event(name: "Women's March", info: "yo",photo: photo1, user: user1!) else {
            fatalError("Unable to instantiate event1")
        }
        
        guard let event2 = Event(name: "Men's March", info: "bye",photo: photo2, user: user1!) else {
            fatalError("Unable to instantiate event2")
        }
        
        guard let event3 = Event(name: "Dog's March", info: "what",photo: photo3, user: user2!) else {
            fatalError("Unable to instantiate event3")
        }
        
        events += [event1, event2, event3]
    }
    
    
    //archive the events array, return true if successful
    private func saveEvents() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Events successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save events.", log: OSLog.default, type: .error)
        }
    } 
    
    //unarchive the object stored at the path Event.ArchiveURL.path and downcast that object to an array of Event objects.
    private func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
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
}
