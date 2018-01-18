//
//  InstagramUserSearchViewController.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 18/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class InstagramUserSearchViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var viewController: InstagramUserSearchViewController!
    
    override func setUp() {
        super.setUp()
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: "InstagramUserSearchViewController") as! InstagramUserSearchViewController
        let _ = self.viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.storyboard = nil
        super.tearDown()
    }
    
    func testResetsTable() {
        let user = InstagramUser()
        user.fullName = "A"
        user.username = "A"
        let data = [user]
        self.viewController.instagramUserData = data
        self.viewController.tableView.reloadData()
        XCTAssertEqual(self.viewController.tableView.numberOfRows(inSection: 0), 1)
        self.viewController.resetTable(cancelRequests: true)
        XCTAssertEqual(self.viewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func testCorrectJSONParsing(){
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "search", ofType: "json")!
        let jsonData = (try? NSData(contentsOfFile: path) as Data)!
        self.viewController.jsonParsing(data: jsonData)
        XCTAssertEqual(self.viewController.instagramUserData.count, 1)
    }
    
    func testCreatesSearchController() {
        self.viewController.createSearchController()
        XCTAssertNotNil(self.viewController.searchContoller)
    }
    
}
