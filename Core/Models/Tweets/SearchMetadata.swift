//
//  SearchMetadata.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/31/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class SearchMetadata: Codable {
    var query: String?
    var count: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case query
        case count
    }
}
