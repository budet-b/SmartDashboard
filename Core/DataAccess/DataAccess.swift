//
//  DataAccess.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation
import Alamofire
import HomeKit

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
    
    static func getWeather(woeid: Int, completed: @escaping ((_ response:[Weather]?, _ error:Error?) -> Void)) -> Void {
        Router.getWeather(woeid).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<[Weather]>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    static func getAccessories(manager: HMHomeManager, completed: @escaping ([HMAccessory]) -> ()){
        var accessoriesRes: [HMAccessory] = []
        if let home = manager.primaryHome {
            for room in home.rooms {
                for accessory in room.accessories {
                    print(accessory.name)
                    if (accessory.category.categoryType == HMAccessoryCategoryTypeOther && accessory.manufacturer == "Philips") || accessory.category.categoryType == HMAccessoryCategoryTypeLightbulb {
                        accessoriesRes.append(accessory)
                        for service in accessory.services {
                            for characteristic in service.characteristics {
                                if let metadata = characteristic.metadata?.manufacturerDescription {
                                    if metadata == "Brightness" {
                                        if let value = characteristic.value {
                                            // On récupère ici la valeur de luminosité
                                            print(value)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        completed(accessoriesRes)
    }

    static func getTopTweets(woeid: Int, completed: @escaping ((_ response: TweetsCollection?, _ error:Error?) -> Void)) {
        Router.getTopTweetFrance(woeid).makeAlamofireRequest { (response, error) in
            if error == nil {
                DecoderJSON<TweetsCollection>().decode(response: response, completed: { (response, error) in
                    completed(response, error)
                })
            }
        }
    }
    
    
}
