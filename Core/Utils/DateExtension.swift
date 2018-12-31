//
//  DateExtension.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/4/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

extension Date {
    func toWeatherDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "/yyyy/MM/dd/"
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func toNewsDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "EEEE d MMMM yyyy"
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    func toTwitterDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM d HH:mm:ss Z yyyy"
        let date = dateFormatter.date(from: self)
        if let date = date {
            let components = Calendar.current.dateComponents([Calendar.Component.hour], from: date)
            return "\(components.hour ?? 0)h"
        }
        return ""
    }
}
