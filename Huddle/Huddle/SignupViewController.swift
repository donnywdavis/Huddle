//
//  SignupViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/1/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for the text fields
        teamNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        teamNameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        confirmPasswordTextField.text = ""
        
        activityIndicator.stopAnimating()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
        // Set up notification observers to see when the keyboard will show or hide
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        // Set up a gesture to dismiss the keyboard when tapping outside of a text field
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        dismissKeyboardTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(dismissKeyboardTap)
    }

}

// MARK: Error Messages

extension SignupViewController {
    
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alertController.addAction(okButton)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
}

// MARK: Gesture Functions

extension SignupViewController {
    
    func dismissKeyboard(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

// MARK: Button Actions

extension SignupViewController {
    
    @IBAction func signupButtonPressed(sender: UIButton) {
        textFieldShouldReturn(confirmPasswordTextField)
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let team = teamNameTextField.text else {
            return
        }
    
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (userInfo, error) in
            guard error == nil else {
                self.activityIndicator.stopAnimating()
                self.displayMessage("Error on Create", message: "There was a problem creating the account.")
                return
            }
            
            guard let userInfo = userInfo else {
                return
            }
            let user = ["email": email, "displayName": "", "team": team]
            FIRDatabase.database().reference().child("users").child(userInfo.uid).setValue(user)
            
            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (userInfo, error) in
                self.activityIndicator.stopAnimating()
                
                guard error == nil else {
                    self.displayMessage("Invalid Signin", message: "Could not sign in. Please check your email and password.")
                    return
                }
                
                self.performSegueWithIdentifier("SignupNewsFeedSegue", sender: nil)
                
//                guard let newsFeedVC = self.storyboard?.instantiateViewControllerWithIdentifier("NewsFeedView") as? NewsFeedViewController else {
//                    return
//                }
//                
//                self.activityIndicator.stopAnimating()
//                newsFeedVC.email = userInfo!.email
//                self.presentViewController(newsFeedVC, animated: true, completion: nil)
            })
        })
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
