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
    var selectedTeam = "The Adams"
    
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
        if let players = teams[selectedTeam]?["members"] {
            return (players?.allKeys.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("PlayerCell", forIndexPath: indexPath) as? StatsPlayerTableViewCell else {
            return UITableViewCell()
        }
        
        guard let players = teams[selectedTeam]?["members"],
            let playersKeys = players?.allKeys as? [String],
            let player = players?[playersKeys[indexPath.row]] as? [String: AnyObject]else {
            return UITableViewCell()
        }
        
        cell.configureCell(player["name"] as! String, games: player["games"] as! Int, pracs: player["pracs"] as! Int, kickAvg: player["kickAvg"] as! Int, homeRuns: player["homeRuns"] as! Int)
        
        return cell
    }
    
}
