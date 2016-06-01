//
//  LoginViewController.swift
//  Huddle
//
//  Created by Donny Davis on 5/31/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

// MARK: Button Actions 

extension LoginViewController {
    
    @IBAction func loginButtonPressed(sender: UIButton) {
    }
    
    @IBAction func signupButtonPressed(sender: UIButton) {
    }
    
}

