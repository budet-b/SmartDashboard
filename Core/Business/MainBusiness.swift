//
//  MainBusiness.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation
import HomeKit

class MainBusiness {
    
    static func getSearchWeather(lattlong: String, completed: @escaping ((_ response:[Location]?, _ error:Error?) -> Void)) -> Void {
        DataAccess.getSearchWeather(lattlong: lattlong) { (response, error) in
            completed(response, error)
        }
    }
    
    static func getWeather(woeid: Int, date: String, completed: @escaping ((_ response:[Weather]?, _ error:Error?) -> Void)) -> Void {
        DataAccess.getWeather(woeid: woeid, date: date) { (response, error) in
            completed(response, error)
        }
    }
    
    static func getAccessories(manager: HMHomeManager, completed: @escaping ([HMAccessory]) -> ()){
        DataAccess.getAccessories(manager: manager) { (response) in
            completed(response)
        }
    }
}
