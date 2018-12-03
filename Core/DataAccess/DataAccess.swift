//
//  DataAccess.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation
import Alamofire

class DataAccess {

    static func getSearchWeather(lattlong: String, completed: @escaping ((_ response:[Location]?, _ error:Error?) -> Void)) -> Void {
        Router.getSearchWeather(lattlong).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[Location]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getWeather(woeid: Int, date: String, completed: @escaping ((_ response:[Weather]?, _ error:Error?) -> Void)) -> Void {
        Router.getWeather(woeid, date).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[Weather]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }

}
