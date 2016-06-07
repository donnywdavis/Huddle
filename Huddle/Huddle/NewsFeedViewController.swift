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
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties

    var postKeys = [String]()
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "huddle"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        DataService.sharedInstance.getNewsFeed { (snapshot) in
            if let postsDictionary: [String: [String: String]] = snapshot.value as? [String: [String: String]] {
                self.posts = []
                for post in postsDictionary.keys {
                    self.posts.append(Post(json: postsDictionary[post]!)!)
                }
                self.tableView.reloadData()
            }
        }
        
    }

}

// MARK: Table View Delegate

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        switch post.type! {
        case "post":
            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! NewsFeedTableViewCell
            cell.configureCell(post)
            return cell
            
        case "schedule":
            let cell = tableView.dequeueReusableCellWithIdentifier("ScheduleCell", forIndexPath: indexPath) as! ScheduleTableViewCell
            cell.configureCell(post)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        switch post.type! {
        case "post":
            return 130.0
            
        case "schedule":
            return 110.0
        
        default:
            return 100.0
        }
    }
    
}

