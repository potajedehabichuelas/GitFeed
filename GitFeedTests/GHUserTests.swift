//
//  GHUserTests.swift
//  GitFeedTests
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import GitFeed

class GHUserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserJSONParser() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testUser", withExtension: "json") else {
            XCTFail("Missing file: testUser.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            
            let userJSON = JSON(jsonContents)
            let user = GHUser(userDict: userJSON)
            
            XCTAssertEqual(user.id, 1)
            XCTAssertEqual(user.login, "octocat")
            XCTAssertEqual(user.avatarUrl, "https://github.com/images/error/octocat_happy.gif")
            XCTAssertEqual(user.url, "https://api.github.com/users/octocat")

        } catch {
            XCTFail("Wrong file: testUser.json")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
