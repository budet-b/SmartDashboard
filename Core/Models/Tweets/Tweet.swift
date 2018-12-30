//
//  Tweet.swift
//  SmartDashboard
//
//  Created by Benjamin_Budet on 17/12/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class Tweet: Codable {
    var name: String?
    var url: String?
    var tweet_volume: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case tweet_volume
    }
}
