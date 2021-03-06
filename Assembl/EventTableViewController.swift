//
//  EventsTableViewController.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 5/18/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

//MARK: Properties

var myEvents = [Event]()
var allEvents = [Event]()

class EventTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myEvents = []
        allEvents = []
        
        if let savedEvents = loadEvents() {
            allEvents += savedEvents
        } else {
            //
        }
        
        
        if let currentUser = loadCurrentUser() {
            let namesOfEvents = currentUser.events
            for event in allEvents {
                if namesOfEvents.contains(event.name) {
                    myEvents.append(event)
                }
            }
        } else {
            //
        }
        
        tableView.reloadData()
        
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
        return myEvents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        
        // Fetches the appropriate event for the data source layout.
        let event = myEvents[indexPath.row]
        
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
            let event = myEvents.remove(at: indexPath.row)
            let eventInAll = events.first(where: { $0.name == event.name })
            if let index = events.index(of: eventInAll!) {
                events.remove(at: index)
            }
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    //MARK: Private Methods
    
    
    private func loadCurrentUser() -> UserModel? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: UserModel.CurrentUserArchiveURL.path) as? UserModel
    }
    
    //unarchive the object stored at the path Event.ArchiveURL.path and downcast that object to an array of Event objects.
    private func loadEvents() -> [Event]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
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
}
