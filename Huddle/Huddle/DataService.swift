//
//  DataService.swift
//  Huddle
//
//  Created by Donny Davis on 6/1/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let sharedInstance = DataService()
    
    private let BASE_REF = FIRDatabase.database().reference()
    private let USER_REF = FIRDatabase.database().reference().child("users")
    private let NEWS_FEED_REF = FIRDatabase.database().reference().child("newsFeed")
    private let TEAMS_REF = FIRDatabase.database().reference().child("teams")
    private var CURRENT_USER: FIRUser?
    
    var baseRef: FIRDatabaseReference {
        return BASE_REF
    }
    
    var userRef: FIRDatabaseReference {
        return USER_REF
    }
    
    var newsFeedRef: FIRDatabaseReference {
        return NEWS_FEED_REF
    }
    
    var teamsRef: FIRDatabaseReference {
        return TEAMS_REF
    }
    
    var currentUser: FIRUser? {
        if let user = CURRENT_USER {
            return user
        } else {
            return nil
        }
    }
    
    func isUserLoggedIn(completion: (Bool) -> Void) {
        FIRAuth.auth()?.addAuthStateDidChangeListener({ (auth, user) in
            if user != nil {
                self.CURRENT_USER = user!
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func getNewsFeed(completion: (FIRDataSnapshot) -> Void) {
        newsFeedRef.observeEventType(.Value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    func getTeams(completion: (FIRDataSnapshot) -> Void) {
        teamsRef.observeEventType(.Value) { (snapshot) in
            completion(snapshot)
        }
    }
    
    func createPost(message: String) {
        let author = ((currentUser?.displayName) != nil) ? currentUser?.displayName : currentUser?.email
        let newPost: [String: String] = ["author": author!, "message": message, "type": "post"]
        newsFeedRef.childByAutoId().setValue(newPost)
    }
    
    func createUserAccount(uid: String, user: [String: String]) {
        userRef.child(uid).setValue(user)
    }
    
}