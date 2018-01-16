//
//  InstagramAccountsHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 15/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

class InstagramAccountsHelper {
    
    static let accountsIdentifier = "AccountsIdentifier"
    
    static func getAccounts() -> [String]?{
        return UserDefaultsHelper.getStringArray(key: accountsIdentifier)
    }
    
    static func addAccount(account: String) -> Bool {
        return UserDefaultsHelper.addStringInArray(key: accountsIdentifier, string: account, shouldVerifyUniqueness: true)
    }
    
    static func deleteAccounts() {
        UserDefaultsHelper.setStringArray(key: accountsIdentifier, array: [])
    }
}
