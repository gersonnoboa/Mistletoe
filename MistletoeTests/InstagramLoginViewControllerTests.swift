//
//  InstagramLoginViewControllerTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class InstagramLoginViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var viewController: InstagramLoginViewController!
    
    override func setUp() {
        super.setUp()
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: "InstagramLoginViewController") as! InstagramLoginViewController
        let _ = self.viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.storyboard = nil
        super.tearDown()
    }
    
    func testLoadWebView() {
        self.viewController.loadWebView()
        XCTAssertTrue(self.viewController.webView.isLoading)
    }
    
    func testSetAccessToken() {
        
        let accessToken = "5"
        self.viewController.setAccessToken(withURL: "\(InstagramAPI.redirectURL)#access_token=\(accessToken)") { (policy) in }
        XCTAssertEqual(InstagramAPI.getAccessToken(), accessToken)
        XCTAssertTrue(self.viewController.isSuccessful)
    }
    
}
