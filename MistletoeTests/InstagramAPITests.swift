//
//  InstagramAPITests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class InstagramAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetCorrectAccessToken() {
        let accessToken = "5"
        InstagramAPI.setAccessToken(token: accessToken)
        
        XCTAssertEqual(UserDefaultsHelper.getString(key: InstagramAPI.accessTokenIdentifier), accessToken)
        
    }
    
    func testGetCorrectAccessToken() {
        let accessToken = "5"
        InstagramAPI.setAccessToken(token: accessToken)
        
        XCTAssertEqual(InstagramAPI.getAccessToken(), accessToken)
    }
    
    func testUserSearchURL() {
        let encodedQuery = "a"
        let token = "5"
        let url = "https://api.instagram.com/v1/users/search?q=\(encodedQuery)&access_token=\(token)"
        
        XCTAssertEqual(InstagramAPI.userSearch(query: encodedQuery, token: token), url)
    }
    
    func testUserMediaURL() {
        let id = "1"
        let token = "5"
        let url = "https://api.instagram.com/v1/users/\(id)/media/recent/?access_token=\(token)"
        
        XCTAssertEqual(InstagramAPI.userMedia(id: id, token: token), url)
    }
    
}
