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
    @IBOutlet weak var cellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String) {
        playerName.text = name
    }

}
