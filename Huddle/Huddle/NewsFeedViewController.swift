//
//  NewsFeedViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/1/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import Firebase

class NewsFeedViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var emailLabel: UILabel!
    
    // Properties
    
    var email: String? {
        didSet {
            emailLabel!.text = email
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: Button Actions

extension NewsFeedViewController {
    
    @IBAction func logoutButtonPressed(sender: UIButton) {
        
        do {
            try FIRAuth.auth()?.signOut()
            self.dismissViewControllerAnimated(true, completion: nil)
        } catch {
            print("Error: \(error)")
        }
        
    }
    
}
