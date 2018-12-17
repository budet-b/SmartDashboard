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
