//
//  Stocks.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/29/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class Stocks: Codable {
    var symbol: String?
    var companyName: String?
    var extendedChange: Double?
    var extendedChangePercent: Double?
    var latestPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case symbol
        case companyName
        case extendedChange
        case extendedChangePercent
        case latestPrice
    }
}
