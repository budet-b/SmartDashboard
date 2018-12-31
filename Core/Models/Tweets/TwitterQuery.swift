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
