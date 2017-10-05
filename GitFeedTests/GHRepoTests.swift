//
//  GHRepoTests.swift
//  GitFeedTests
//
//  Created by Daniel Bolivar herrera on 5/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import GitFeed

class GHRepoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "testRepo", withExtension: "json") else {
            XCTFail("Missing file: testRepo.json")
            return
        }
        
        do {
            let jsonContents = try Data(contentsOf: url)
            
            let repoJSON = JSON(jsonContents)
            let repo = GHRepo(repoDict: repoJSON)
            
            XCTAssertEqual(repo.id, 3)
            XCTAssertEqual(repo.name, "octocat/Hello-World")
            XCTAssertEqual(repo.url, "https://api.github.com/repos/octocat/Hello-World")
            
        } catch {
            XCTFail("Wrong file: testRepo.json")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
