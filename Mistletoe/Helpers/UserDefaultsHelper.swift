//
//  UserDefaultsHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {

    static let accountsIdentifier = "AccountsIdentifier"
    static let accessTokenIdentifier = "AccessTokenIdentifier"
    
    static func numberOfAccounts() -> Int {
        let accounts = getAccounts()
        return accounts.count
    }
    
    static func getAccounts() -> [String] {
        let defaults = UserDefaults.standard
        let accounts = defaults.stringArray(forKey: accountsIdentifier)
        guard let acc = accounts else { return [] }
        return acc
    }
    
    static func saveNewAccount(account: String) {
        let defaults = UserDefaults.standard
        var accounts = getAccounts()
        accounts.append(account)
        
        defaults.set(accounts, forKey: accountsIdentifier)
    }
    
    static func getAccessToken() -> String? {
        let defaults = UserDefaults.standard
        let accessToken = defaults.string(forKey: accessTokenIdentifier)
        return accessToken
    }
    
    static func saveAccessToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: accessTokenIdentifier)
    }
}
