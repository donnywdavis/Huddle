//
//  Post.swift
//  Huddle
//
//  Created by Donny Davis on 6/2/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

import Foundation
import Gloss

struct Post: Decodable {
    var type: String?
    var author: String?
    var message: String?
    
    init?(json: JSON) {
        self.type = "type" <~~ json
        self.author = "author" <~~ json
        self.message = "message" <~~ json
    }
}
