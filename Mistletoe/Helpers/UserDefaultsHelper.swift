//
//  UserDefaultsHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {
    
    //not used, will not be tested
    static func countStringArray(key: String) -> Int {
        let array = getStringArray(key: key)
        guard let a = array else { return 0 }
        return a.count
    }
    
    static func setStringArray(key: String, array: [String]?) {
        let defaults = UserDefaults.standard
        defaults.set(array, forKey: key)
    }
    
    static func addStringInArray(key: String, string: String) {
        let _ = addStringInArray(key: key, string: string, shouldVerifyUniqueness: false)
    }
    
    static func addStringInArray(key: String, string: String, shouldVerifyUniqueness: Bool) -> Bool {
        var array = getStringArray(key: key)
        if let _ = array { }
        else {
            array = []
        }
        
        let isUnique = array!.contains(string)
        if (shouldVerifyUniqueness && !isUnique) || !shouldVerifyUniqueness {
            array!.append(string)
            setStringArray(key: key, array: array!)
            return true;
        }
        else {
            return false;
        }
    }
    
    static func getStringArray(key: String) -> [String]? {
        let defaults = UserDefaults.standard
        let array = defaults.stringArray(forKey: key)
        return array
    }
    
    //end of not used
    
    static func getString(key: String) -> String? {
        let defaults = UserDefaults.standard
        let string = defaults.string(forKey: key)
        return string
    }
    
    static func setString(key: String, value: String?) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func getObjectArray(key: String) -> [NSCoding]? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else { return nil }
        let decoded = NSKeyedUnarchiver.unarchiveObject(with: data) as? [NSCoding]
        return decoded
        
    }
    static func addObjectInArray(key: String, object: NSCoding) {
        var array = getObjectArray(key: key)
        
        if array == nil {
            array = []
        }
        
        array?.append(object)
        setObjectArray(key: key, array: array)
    }
    
    static func setObjectArray(key: String, array: [NSCoding]?) {
        let defaults = UserDefaults.standard
        let encoded = NSKeyedArchiver.archivedData(withRootObject: array as Any)
        defaults.set(encoded, forKey: key)
    }
    
}
