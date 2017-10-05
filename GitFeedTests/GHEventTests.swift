//
//  GHEventTests.swift
//  GitFeedTests
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import GitFeed

class GHEventTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventJSONParser() {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testEvent", withExtension: "json") else {
            XCTFail("Missing file: testEvent.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            
            let eventJSON = JSON(jsonContents)
            let event = GHEvent(eventDict: eventJSON)
            
            XCTAssertEqual(event.type, "Event")
            
            XCTAssertEqual(event.id, "12345")
            
            let isoFormatter = ISO8601DateFormatter()
            let dateString = isoFormatter.string(from: event.createdAt)
            XCTAssertEqual(dateString, "2011-09-06T17:26:27Z")
            
        } catch {
            XCTFail("Wrong file: testEvent.json")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
