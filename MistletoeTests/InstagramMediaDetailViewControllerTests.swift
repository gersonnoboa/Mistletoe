//
//  InstagramMediaDetailViewControllerTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class InstagramMediaDetailViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var viewController: InstagramMediaDetailViewController!
    var media: InstagramMedia!
    
    override func setUp() {
        super.setUp()
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: "InstagramMediaDetailViewController") as! InstagramMediaDetailViewController
        
        self.media = InstagramMedia()
        self.media.likes = 10
        self.media.comments = 5
        self.media.createdTime = "1500741400"
        self.viewController.instagramMedia = self.media
        
        let _ = self.viewController.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.media = nil
        self.viewController = nil
        self.storyboard = nil
        super.tearDown()
    }
    
    func testSetupView(){
        self.viewController.setUpView()
        XCTAssertEqual(self.viewController.likes.text, "\(self.media.likes) likes")
        XCTAssertEqual(self.viewController.comments.text, "\(self.media.comments) comments")
        XCTAssertEqual(self.viewController.postedOn.text, "July 22, 2017")
        
        self.viewController.instagramMedia.likes = 1
        self.viewController.instagramMedia.comments = 1
        self.viewController.instagramMedia.createdTime = "a"
        self.viewController.setUpView()
        
        XCTAssertEqual(self.viewController.likes.text, "\(self.media.likes) like")
        XCTAssertEqual(self.viewController.comments.text, "\(self.media.comments) comment")
        XCTAssertEqual(self.viewController.postedOn.text, "Recently")
    }
    
}
