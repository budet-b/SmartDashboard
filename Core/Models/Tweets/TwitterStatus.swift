//
//  TwitterStatus.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/31/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class TwitterStatus: Codable {
    var created_at: String?
    var text: String?
    var truncated: Bool?
    var user: TwitterUser?
    var retweet_count: Int?
    var favorite_count: Int?
    
    enum CodingKeys: String, CodingKey {
        case created_at
        case text
        case truncated
        case user
        case retweet_count
        case favorite_count
    }
}
