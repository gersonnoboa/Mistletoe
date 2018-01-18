//
//  MistletoeTests.swift
//  MistletoeTests
//
//  Created by Gerson Noboa on 12/1/18.
//  Copyright © 2018 Heavenlapse. All rights reserved.
//

import XCTest
@testable import Mistletoe

class AccountsViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var viewController: AccountsViewController!
    
    override func setUp() {
        super.setUp()
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = self.storyboard.instantiateViewController(withIdentifier: "AccountsViewController") as! AccountsViewController
        let _ = viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewController = nil
        self.storyboard = nil
        super.tearDown()
    }
    
    func testLogsOutOfInstagram() {
        let accounts = [InstagramUser()]
        self.viewController.accounts = accounts
        XCTAssertTrue(self.viewController.accounts.count == 1)
        self.viewController.executeLogOutOfInstagram()
        XCTAssertTrue(self.viewController.accounts.count == 0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTableViewLoadsAccounts() {
        let accounts = [InstagramUser()]
        InstagramAccountsHelper.setAccounts(accounts: accounts)
        self.viewController.loadAccounts()
        XCTAssertTrue(self.viewController.tableView.numberOfRows(inSection: 0) == accounts.count)
    }
    
    func testGetsCorrectLoginStatus() {
        InstagramAPI.setAccessToken(token: "token")
        XCTAssertTrue(self.viewController.hasLoggedInToInstagram())
        InstagramAPI.setAccessToken(token: nil)
        XCTAssertFalse(self.viewController.hasLoggedInToInstagram())
    }
    
    func testDeletesSingleAccount() {
        let accounts = [InstagramUser()]
        self.viewController.accounts = accounts
        self.viewController.executeDeleteAccount(senderTag: Optional(0))
        XCTAssertTrue(self.viewController.accounts.count == 0)
    }
    
    func testCorrectStatusView() {
        InstagramAPI.setAccessToken(token: "token")
        self.viewController.determineLogInStatus()
        XCTAssertTrue(self.viewController.logInStatusView.backgroundColor == UIColor.green)
        InstagramAPI.setAccessToken(token: nil)
        self.viewController.determineLogInStatus()
        XCTAssertTrue(self.viewController.logInStatusView.backgroundColor == UIColor.red)
    }
    
}
