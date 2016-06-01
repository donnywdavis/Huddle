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
    @IBOutlet weak var scrollViewContent: UIView!
    

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the delegate for the text fields
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.enabled = false
        
        activityIndicator.stopAnimating()
        
        // Set up notification observers to see when the keyboard will show or hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Remove the notification observers when dismissing the view
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}

// MARK: Button Actions 

extension LoginViewController {
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        textFieldShouldReturn(passwordTextField)
    }
    
    @IBAction func signupButtonPressed(sender: UIButton) {
    }
    
}

// MARK: Keyboard Notifications

extension LoginViewController {
    
    func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else {
            return
        }
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        if emailTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(emailTextField.frame, animated: true)
        } else if passwordTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(passwordTextField.frame, animated: true)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
}

// MARK: Text Field Delegates

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if passwordTextField.isFirstResponder() {
            loginButton.enabled = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if emailTextField.isFirstResponder() {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            
        } else if passwordTextField.isFirstResponder() {
            passwordTextField.resignFirstResponder()
            activityIndicator.startAnimating()
        }
        
        return true
        
    }
    
}

