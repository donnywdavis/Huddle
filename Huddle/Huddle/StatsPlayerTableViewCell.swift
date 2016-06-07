//
//  StatsPlayerTableViewCell.swift
//  Huddle
//
//  Created by Donny Davis on 6/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class StatsPlayerTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var gamesLabel: UILabel!
    @IBOutlet weak var pracsLabel: UILabel!
    @IBOutlet weak var kickAvgLabel: UILabel!
    @IBOutlet weak var homeRunsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String, games: Int, pracs: Int, kickAvg: Int, homeRuns: Int) {
        playerName.text = name
        gamesLabel.text = String(games)
        pracsLabel.text = String(pracs)
        kickAvgLabel.text = String(kickAvg)
        homeRunsLabel.text = String(homeRuns)
    }

}
