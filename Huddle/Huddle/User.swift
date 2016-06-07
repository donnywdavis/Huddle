//
//  User.swift
//  Huddle
//
//  Created by Donny Davis on 6/1/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import Foundation
import Gloss

struct User: Decodable {
    var name: String?
    var team: String?
    
    init?(json: JSON) {
        self.name = "name" <~~ json
        self.team = "team" <~~ json
    }
}