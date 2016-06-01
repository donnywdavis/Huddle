//
//  SignupViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/1/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the text fields
        teamNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        activityIndicator.stopAnimating()
        
        signupButton.layer.cornerRadius = 5
        
        // Set up notification observers to see when the keyboard will show or hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

}

// MARK: Button Actions

extension SignupViewController {
    
    @IBAction func signupButtonPressed(sender: UIButton) {
        textFieldShouldReturn(confirmPasswordTextField)
    }
    
}

// MARK: Keyboard Notifications

extension SignupViewController {
    
    func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue().size else {
            return
        }
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        if teamNameTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(teamNameTextField.frame, animated: true)
        } else if emailTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(emailTextField.frame, animated: true)
        } else if passwordTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(passwordTextField.frame, animated: true)
        } else if confirmPasswordTextField.isFirstResponder() {
            scrollView.scrollRectToVisible(confirmPasswordTextField.frame, animated: true)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let contentInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
}

// MARK: Text Field Delegates

extension SignupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if confirmPasswordTextField.isFirstResponder() {
            signupButton.enabled = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if teamNameTextField.isFirstResponder() {
            teamNameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else if emailTextField.isFirstResponder() {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            
        } else if passwordTextField.isFirstResponder() {
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        } else if confirmPasswordTextField.isFirstResponder() {
            confirmPasswordTextField.resignFirstResponder()
            activityIndicator.startAnimating()
        }
        
        return true
        
    }
    
}
