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
    
    static func getWeather(woeid: Int, completed: @escaping ((_ response:[Weather]?, _ error:Error?) -> Void)) -> Void {
        DataAccess.getWeather(woeid: woeid) { (response, error) in
            completed(response, error)
        }
    }
    
    static func getNews(completed: @escaping ((_ response: News?, _ error: Error?) -> Void)) -> Void {
        DataAccess.getNews() { (response, error) in
            completed(response, error)
        }
    }
    
    static func getAccessories(manager: HMHomeManager, completed: @escaping ([HMAccessory]) -> ()){
        DataAccess.getAccessories(manager: manager) { (response) in
            completed(response)
        }
    }
    

    static func getTopTweetsFrance(completed: @escaping ((_ response: TweetsCollection?, _ error: Error?) -> Void)) -> Void {
        // 23424819 = France top tweets
        DataAccess.getTopTweets(woeid: 23424819) { (response, error) in
            completed(response, error)
        }

    static func getStocks(completed: @escaping ((_ response:[Stocks]?, _ error:Error?) -> Void)) -> Void {
        DataAccess.getStocks(completed: { (response, error) in
            completed(response, error)
        })

    }
}
