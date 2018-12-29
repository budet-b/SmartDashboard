//
//  Router.swift
//  Board
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 EpiMac. All rights reserved.
//

import Foundation
import Alamofire

public enum Router {
    case getTest()
    case getSearchWeather(String)
    case getWeather(Int)
    case getTopTweetFrance(Int)
    case getNews()
}

extension Router : RouterProtocol {
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getTest:
            return .get
        case .getSearchWeather:
            return .get
        case .getWeather:
            return .get
        case .getTopTweetFrance:
        case .getNews:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getTest:
            return Constants.Url.BASE_URL
        case .getSearchWeather(let lattlong):
            return Constants.Url.WeatherAPI.BASE_URL + Constants.Url.WeatherAPI.SEARCH + lattlong
        case .getWeather(let woeid):
            return Constants.Url.WeatherAPI.BASE_URL + "\(woeid)" + Date().toWeatherDate()
        case .getTopTweetFrance(let woeid):
            return Constants.Url.TwitterURLTopTweets + "\(woeid)"
        case .getNews:
            return Constants.Url.TOP_HEADLINES_NEWS
        }
    }
    
    internal var headers: HTTPHeaders {
        return HTTPHeaders.init()
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        var parameters: Parameters?
        
        switch self {
            //        case .postSubscribedGroups(let service, let registration_id, let host):
            //            parameters = [
            //                "service": service,
            //                "registration_id": registration_id,
            //                "host": host
        //            ]
        default:
            break
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            let data = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
        }
        return request
    }
    
    
    func makeAlamofireRequest(completionHandler: @escaping (_ data: DataResponse<Data>?, _ error: Error?) -> ()) {
        Alamofire.request(self.urlRequest).validate().responseData { (response) in
            completionHandler(response, response.result.error)
        }
    }
}


extension Router: URLRequestConvertible {
    public func asURLRequest () throws -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: self.path)!)
        urlRequest.httpMethod = self.method.rawValue
        return urlRequest
    }
}
