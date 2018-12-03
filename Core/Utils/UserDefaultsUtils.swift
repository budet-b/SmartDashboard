//
//  UserDefaultsUtils.swift
//  SmartDashboard
//
//  Created by Alexandre Toubiana on 12/3/18.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import Foundation

class UserDefaultsUtils: NSObject {
    
    //MARK: Data Key used
    
    static let woeid: String = "woeid"
    
    //MARK: Set datas
    
    class func saveData(key: String, value: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: key)
    }
    
    class func saveData(key: String, value: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: key)
    }
    
    //MARK: Get datas
    
    class func getData(key: String) -> String {
        let userDefaults = UserDefaults.standard
        if let object : String = userDefaults.value(forKey: key) as? String {
            return object
        }
        else {
            return ""
        }
    }
    
    class func getDataBool(key: String) -> Bool {
        let userDefaults = UserDefaults.standard
        if let object : Bool = userDefaults.value(forKey: key) as? Bool {
            return object
        }
        else {
            return false
        }
    }
    
    //MARK: Remove datas
    
    class func removeData(key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }
}

