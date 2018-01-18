//
//  UserDefaultsHelperTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class UserDefaultsHelperTests: XCTestCase {
    
    var instagramUser: InstagramUser!
    var defaults: UserDefaults!
    var key: String!
    var value: String!
    var objectArrayValue: [InstagramUser]!
    
    override func setUp() {
        super.setUp()
        self.instagramUser = InstagramUser()
        instagramUser.id = "gersonnoboa"
        
        self.defaults = UserDefaults.standard
        self.key = "a"
        self.value = "1"
        self.objectArrayValue = [self.instagramUser]
    }
    
    override func tearDown() {
        UserDefaultsHelper.setString(key: self.key, value: nil)
        self.key = nil
        self.value = nil
        self.defaults = nil
        self.instagramUser = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetString() {
        defaults.set(self.value, forKey: self.key)
        let fromDefaults = defaults.string(forKey: self.key)
        
        let string = UserDefaultsHelper.getString(key: self.key)
        
        XCTAssertEqual(fromDefaults, string)
    }
    
    func testGetString() {
        UserDefaultsHelper.setString(key: self.key, value: self.value)
        
        let fromDefaults = defaults.string(forKey: self.key)
        XCTAssertEqual(UserDefaultsHelper.getString(key: self.key), fromDefaults)
    }
    
    func testGetAndSetObjectArray(){
        UserDefaultsHelper.setObjectArray(key: self.key, array: self.objectArrayValue)
        
        let array = UserDefaultsHelper.getObjectArray(key: self.key)!
        let element = array[0] as! InstagramUser
        
        let comparingElement = self.objectArrayValue[0]
        
        XCTAssertEqual(element.id, comparingElement.id)
    }
    
    func testAddObjectInArray(){
        UserDefaultsHelper.setObjectArray(key: self.key, array: self.objectArrayValue)
        
        let second = InstagramUser()
        second.id = "masamarillo"
        UserDefaultsHelper.addObjectInArray(key: self.key, object: second)
        
        let array = UserDefaultsHelper.getObjectArray(key: self.key)
        XCTAssertEqual(array?.count, 2)
    }
    
}
