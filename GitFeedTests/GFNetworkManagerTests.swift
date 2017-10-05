//
//  GFNetworkManagerTests.swift
//  GitFeedTests
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest

@testable import GitFeed

class GFNetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventFeedRequest() {
        
        let ex = expectation(description: "Expecting a JSON Event Feed data")
        
        GFNetworkManager.sharedInstance.getGithubEventFeed(completion: { eventFeed in
          
            XCTAssertNotNil(eventFeed)
            if let evFeed = eventFeed {
                XCTAssertGreaterThanOrEqual(evFeed.count, 0)
            }
            ex.fulfill()
            
        })
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
