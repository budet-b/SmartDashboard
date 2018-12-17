//
//  Article.swift
//  SmartDashboard
//
//  Created by Benjamin_Budet on 17/12/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var image: String?
    var url: String?
    var content: String?
    var publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case image
        case url
        case content
        case publishedAt
    }
}
