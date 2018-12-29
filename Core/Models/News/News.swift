//
//  News.swift
//  SmartDashboard
//
//  Created by Benjamin_Budet on 17/12/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
