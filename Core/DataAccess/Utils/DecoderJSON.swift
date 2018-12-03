//
//  DecoderJSON.swift
//  SmartDashboard
//
//  Created by Benjamin Budet on 12/3/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation
import Alamofire

class DecoderJSON<T: Codable> {
    func decode(data: Data?, response: URLResponse?, error: Error?, completed: (T?, Error?) -> ()) {
        do {
            let decoder = JSONDecoder()
            print(String(data: data!, encoding: .utf8) ?? "")
            let dataRes = try decoder.decode(T.self, from: data!)
            completed(dataRes, error)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func decode(data: [String: Any], completed: (T?, Error?) -> ()) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let reqJSONStr = String(data: jsonData, encoding: .utf8)
            let data = reqJSONStr?.data(using: .utf8)
            let decoder = JSONDecoder()
            let dataRes = try decoder.decode(T.self, from: data!)
            completed(dataRes, nil)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func decode(response: DataResponse<Data>?, completed: (T?, Error?) -> ()) {
        do {
            let decoder = JSONDecoder()
            let dataRes = try decoder.decode(T.self, from: (response?.data!)!)
            completed(dataRes, nil)
        }
        catch let error {
            completed(nil, error)
        }
    }
    
    func encode(data: T) -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        catch _ {
            return nil
        }
    }
    
    func toString(data: T) -> String {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(data)
            return String(data: jsonData, encoding: String.Encoding.utf8) ?? ""
        }
        catch _ {
            return ""
        }
    }
}

extension Encodable {
    func toJSONString() -> String? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        }
        catch _ {
            return nil
        }
    }
    
    func toJSON() -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        catch _ {
            return nil
        }
    }
}

public struct Safe<Base: Codable>: Codable {
    public let value: Base?
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            assertionFailure("ERROR: \(error)")
            self.value = nil
        }
    }
}

