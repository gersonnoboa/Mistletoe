//
//  InstagramAccountsHelper.swift
//  Mistletoe
//
//  Created by Gerson Noboa on 15/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import Foundation

struct InstagramAccountsHelper {
    static let accountsIdentifier = "AccountsIdentifier"
}

extension InstagramAccountsHelper {
    static func getAccounts() -> [InstagramUser]?{
        return UserDefaultsHelper.getObjectArray(key: accountsIdentifier) as? [InstagramUser]
    }
    
    static func addAccount(account: InstagramUser) -> Bool {
        let accounts = getAccounts()
        
        if (accounts != nil) {
            
            let accountExists = accounts!.contains(where: { (user) -> Bool in
                return user.id == account.id
            })
            
            if (accountExists) {
                return false
            }
        }
        
        UserDefaultsHelper.addObjectInArray(key: accountsIdentifier, object: account)
        return true
    }
    
    static func deleteAccounts() {
        setAccounts(accounts: nil)
    }
    
    static func setAccounts(accounts: [NSCoding]?) {
        UserDefaultsHelper.setObjectArray(key: accountsIdentifier, array: accounts)
    }
}
