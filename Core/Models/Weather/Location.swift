//
//  Location.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation

class Location: Codable {
    var distance: Int?
    var title: String?
    var location_type: String?
    var woeid: Int?
    var latt_long: String?
    
    enum CodingKeys: String, CodingKey {
        case distance
        case title
        case location_type
        case woeid
        case latt_long
    }
}
