//
//  TwitterQuery.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/31/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class TwitterQuery: Codable {
    var statuses: [TwitterStatus]?
    var search_metadata: SearchMetadata?
    
    enum CodingKeys: String, CodingKey {
        case statuses
        case search_metadata
    }
}

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

class SearchMetadata: Codable {
    var query: String?
    var count: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case query
        case count
    }
}
