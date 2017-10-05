//
//  GHCommitCommentTest.swift
//  GitFeedTests
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import GitFeed

class GHCommitCommentTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCommitCommentJSONParser() {
 
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testCommitComment", withExtension: "json") else {
            XCTFail("Missing file: testCommitComment.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            
            let commitCommentJSON = JSON(jsonContents)
            let comment = GHCommitComment(commitCommentDict: commitCommentJSON)
            
            XCTAssertEqual(comment.user.id, 6752317)
            XCTAssertEqual(comment.id, 11056394)
            XCTAssertEqual(comment.comment, "This is a really good change! :+1:")
            
            let isoFormatter = ISO8601DateFormatter()
            let dateString = isoFormatter.string(from: comment.createdAt)
            XCTAssertEqual(dateString, "2015-05-05T23:40:29Z")
            
        } catch {
            XCTFail("Wrong file: testCommitComment.json")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

