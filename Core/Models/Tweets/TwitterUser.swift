//
//  TwitterUser.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/31/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class TwitterUser: Codable {
    var name: String?
    var screen_name: String?
    var verified: Bool?
    var profile_image_url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case screen_name
        case verified
        case profile_image_url
    }
}
