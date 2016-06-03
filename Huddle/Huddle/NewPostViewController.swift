//
//  NewPostViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/2/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: Properties

    override func viewDidLoad() {
        super.viewDidLoad()

        postView.layer.cornerRadius = 7
    }

}

// MARK: Button Actions

extension NewPostViewController {
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postButtonPressed(sender: UIButton) {
        guard let post = textView.text where textView != "" else {
            return
        }
        
        DataService.sharedInstance.createPost(post)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
