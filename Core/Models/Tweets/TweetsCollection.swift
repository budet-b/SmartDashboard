//
//  TweetsCollection.swift
//  SmartDashboard
//
//  Created by Benjamin_Budet on 17/12/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class TweetsCollection: Codable {
    var trends: [Tweet]?
    
    enum CodingKeys: String, CodingKey {
        case trends
    }
}
