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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
