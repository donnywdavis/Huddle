//
//  StatsViewController.swift
//  Huddle
//
//  Created by Donny Davis on 6/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var teams = [String: AnyObject]()
    var teamNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DataService.sharedInstance.getTeams { (snapshot) in
            if let teams = (snapshot.value as? [String: AnyObject]) {
                self.teamNames = [String](teams.keys)
                self.teams = teams
            } else {
                self.teams = [:]
                self.teamNames = []
            }
            self.tableView.reloadData()
        }
    }

}

extension StatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as? StatsPlayerTableViewCell else {
            return UITableViewCell()
        }
        
        let team = teamNames[indexPath.row]
        let player = teams[team]!["members"]!!["player1"]!!["name"] as! String
        cell.configureCell(player)
        
        return cell
    }
    
}
