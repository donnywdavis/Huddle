//
//  ProfileViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/2/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Properties
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        logoutButton.layer.cornerRadius = 5
        
        // Set up notification observers to see when the keyboard will show or hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Set up a gesture to dismiss the keyboard when tapping outside of a text field
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        dismissKeyboardTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove the notification observers when dismissing the view
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: Gesture Actions

extension ProfileViewController {
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        
        let imageOptions = UIAlertController(title: nil, message: "Choose Options", preferredStyle: .ActionSheet)
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .Default) { (action) in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .PhotoLibrary
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        }
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (action) in
            print("Take Photo")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        imageOptions.addAction(choosePhoto)
        imageOptions.addAction(takePhoto)
        imageOptions.addAction(cancel)
        
        presentViewController(imageOptions, animated: true, completion: nil)
    }
    
    func dismissKeyboard(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: Button Actions

extension ProfileViewController {
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        
        
        
    }
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        
        try! FIRAuth.auth()?.signOut()
        
    }
    
}

// MARK: Keyboard Notifications

extension ProfileViewController {
    
    func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else {
            return
        }
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        if displayNameTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(displayNameTextField.frame, animated: true)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
}

// MARK: Image Picker Delegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profileImage.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
