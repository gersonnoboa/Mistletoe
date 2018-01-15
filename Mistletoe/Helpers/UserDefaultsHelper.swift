//
//  UserDefaultsHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {
    
    static func countStringArray(key: String) -> Int {
        let array = getStringArray(key: key)
        guard let a = array else { return 0 }
        return a.count
    }
    
    static func setStringInArray(key: String, string: String) {
        let defaults = UserDefaults.standard
        var array = getStringArray(key: key)
        if let _ = array { }
        else {
            array = []
        }
        array!.append(string)
        
        defaults.set(array, forKey: key)
    }
    
    static func getStringArray(key: String) -> [String]? {
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey: key)
        return array
    }
    
    static func getString(key: String) -> String? {
        let defaults = UserDefaults.standard
        let string = defaults.string(forKey: key)
        return string
    }
    
    static func setString(key: String, value: String?) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
}
