//
//  ScheduleTableViewCell.swift
//  Huddle
//
//  Created by Donny Davis on 6/3/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var scheduleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.scheduleLabel.text = post.message
    }

}
