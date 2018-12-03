//
//  Weather.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation

class Weather: Codable {
    var weather_state_name: String?
    var weather_state_abbr: String?
    var wind_direction_compass: String?
    var created: String?
    var applicable_date: String?
    var min_temp: Double?
    var max_temp: Double?
    var the_temp: Double?
    var wind_speed: Double?
    var wind_direction: Double?
    var air_pressure: Double?
    
    enum CodingKeys: String, CodingKey {
        case weather_state_name
        case weather_state_abbr
        case wind_direction_compass
        case created
        case applicable_date
        case min_temp
        case max_temp
        case the_temp
        case wind_speed
        case wind_direction
        case air_pressure
    }
}

