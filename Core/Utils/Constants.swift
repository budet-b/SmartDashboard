//
//  Constants.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation

struct Constants {
    struct Url {
        static let BASE_URL      = "http://google.com"        //GET
        
        struct WeatherAPI {
            static let BASE_URL = "https://www.metaweather.com/api/location/"
            static let SEARCH   = "search/?lattlong="
        }
        
        static let TwitterURLTopTweets = "https://api.twitter.com/1.1/trends/place.json?id="
        static let TOP_HEADLINES_NEWS = "https://newsapi.org/v2/top-headlines?country=fr&apiKey="
        static let BEARER_TOKEN_TWITTER = ""
    }
    
    static let weatherStatus = [
        "sn" : "Neigeux",
        "sl" : "Neige fondue",
        "h"  : "Grêle",
        "t"  : "Orage",
        "hr" : "Forte pluie",
        "lr" : "Pluie légère",
        "s"  : "Pluvieux",
        "hc" : "Très couvert",
        "lc" : "Partiellement couvert",
        "c"  : "Éclaircies"
    ]
}
