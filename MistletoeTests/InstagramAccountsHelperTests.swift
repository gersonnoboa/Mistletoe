//
//  InstagramAccountsHelperTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class InstagramAccountsHelperTests: XCTestCase {
    
    var instagramUser: InstagramUser!
    
    override func setUp() {
        super.setUp()
        self.instagramUser = InstagramUser()
        instagramUser.id = "gersonnoboa"
        InstagramAccountsHelper.deleteAccounts()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        InstagramAccountsHelper.deleteAccounts()
        self.instagramUser = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetAccounts(){
        
        let array = [self.instagramUser]
        UserDefaultsHelper.setObjectArray(key: InstagramAccountsHelper.accountsIdentifier, array: (array as! [NSCoding]))
        
        let obtained = InstagramAccountsHelper.getAccounts()![0]
        XCTAssertEqual(self.instagramUser.id, obtained.id)
    }
    
    func testAddAccounts() {
        XCTAssertTrue(InstagramAccountsHelper.addAccount(account: self.instagramUser))
        XCTAssertEqual(InstagramAccountsHelper.getAccounts()!.count, 1)
        
        let secondInstagramUser = InstagramUser()
        secondInstagramUser.id = "masamarillo"
        XCTAssertTrue(InstagramAccountsHelper.addAccount(account: secondInstagramUser))
        XCTAssertEqual(InstagramAccountsHelper.getAccounts()!.count, 2)
    }
    
    func testDeleteAccounts(){
        XCTAssertTrue(InstagramAccountsHelper.addAccount(account: self.instagramUser))
        XCTAssertEqual(InstagramAccountsHelper.getAccounts()!.count, 1)
        
        InstagramAccountsHelper.deleteAccounts()
        XCTAssertNil(InstagramAccountsHelper.getAccounts())
    }
    
}
