//
//  SwiftNetworkTDD_AppivateExampleCodeTests.swift
//  SwiftNetworkTDD-AppivateExampleCodeTests
//
//  Created by Gary Maccabe on 14/12/2021.
//

import XCTest
@testable import SwiftNetworkTDD_AppivateExampleCode

class SwiftNetworkTDD_AppivateExampleCodeTests : XCTestCase {
    
    var sut : BeerListingViewController!

    override func setUpWithError() throws {
        super.setUp()
        sut = BeerListingViewController.instanceFromStoryboard()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
