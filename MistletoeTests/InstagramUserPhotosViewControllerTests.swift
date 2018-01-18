//
//  InstagramUserPhotosViewControllerTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe
class InstagramUserPhotosViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var viewController: InstagramUserPhotosViewController!
    var user: InstagramUser!
    
    override func setUp() {
        super.setUp()
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: "InstagramUserPhotosViewController") as! InstagramUserPhotosViewController
        
        self.user = InstagramUser()
        self.user.fullName = "Gerson"
        self.user.bio = "Bio"
        self.user.id = "1"
        self.user.isBusiness = false
        self.user.profilePicture = "https://scontent.cdninstagram.com/t51.2885-19/928852_1680501938835776_1485819708_a.jpg"
        self.user.username = "gersonnoboa"
        self.user.website = "www.heavenlapse.com"
        self.viewController.user = self.user
        
        let _ = self.viewController.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.storyboard = nil
        super.tearDown()
    }
    
    func testSetupViews(){
        self.viewController.setUpViews()
        XCTAssertEqual(self.viewController.bio.text, self.user.bio)
        XCTAssertEqual(self.viewController.name.text, self.user.fullName)
        XCTAssertEqual(self.viewController.website.text, self.user.website)
    }
    
    func testJSONParsing() {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "media", ofType: "json")!
        let jsonData = (try? NSData(contentsOfFile: path) as Data)!
        self.viewController.jsonParsing(data: jsonData)
        XCTAssertEqual(self.viewController.instagramMedia.count, 20)
        XCTAssertEqual(self.viewController.collectionView.numberOfItems(inSection: 0), 20)
    }
}
