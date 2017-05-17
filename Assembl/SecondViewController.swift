//
//  SecondViewController.swift
//  Assembl
//
//  Created by Kiara Wahnschafft on 3/29/17.
//  Copyright © 2017 KSK. All rights reserved.
//

import UIKit
import os.log

class SecondViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var EventNameTextField: UITextField!
    @IBOutlet weak var EventDescriptionTextField: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `EventTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new event.
     */
    var event: Event?
    
    @IBAction func CreateEventButton(_ sender: Any) {
    
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //textField.resignFirstResponder()
        //return true
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text //sets the title of the scene to the event name
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        EventNameTextField.delegate = self
        
        // Set up views if editing an existing Event.
        if let event = event {
            navigationItem.title = event.name
            EventNameTextField.text = event.name
            EventDescriptionTextField.text = event.info
            photoImageView.image = event.photo
        }
        
        // Enable the Save button only if the text field has a valid Event name.
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }

    //MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on whether user is adding new event or editing old event,this view controller needs to be dismissed in two different ways.
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        
        os_log("ASDLFJALSDFJLADSJFLSJDFLAJSDFLASJFLASJDFLASJDFLJSADLFJASLDFJLKDFJLASJDFLAJDSF")
        print("\(presentingViewController)")
        
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController{ //editing existing event (event scene was pushed onto navigation stack)
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The SecondViewController is not inside a navigation controller.")
        }
    }
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = EventNameTextField.text ?? "" //return the value if there is one, otherwise return default of ""
        let info = EventDescriptionTextField.text ?? ""
        let photo = photoImageView.image
        let tempUser = UserModel(username: "what", password: "hey", email: "k@gmail.com", events: [])
        
        os_log("YOYO")
        // Set the event to be passed to SecondViewController after the unwind segue.
        event = Event(name: name, info: info, photo: photo, user: tempUser)
    }
    
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        // Hide the keyboard.
        EventNameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
   
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = EventNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

