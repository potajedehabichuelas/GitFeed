//
//  GitFeedUITests.swift
//  GitFeedUITests
//
//  Created by Daniel Bolivar herrera on 4/10/17.
//  Copyright © 2017 Casumo. All rights reserved.
//

import XCTest

class GitFeedUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRefreshButton() {
        XCUIApplication().navigationBars["GitHub Feed"].buttons["Refresh"].tap()
    }
    
    func testFeedTableViewSearchController() {
        let app = XCUIApplication()
        app.tables.searchFields["filter Events"].tap()
        app.searchFields["filter Events"].typeText("A")
    }
    
    func testCheckUserProfile() {
        //Not of much use unless we use a fixed JSON file for testing :/. As this is a real feed the usernames change constantly
        //Same scenario will occur to test commit comments
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.buttons["@viseth89"]/*[[".cells.buttons[\"@viseth89\"]",".buttons[\"@viseth89\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["User Profile"].buttons["GitHub Feed"].tap()
        
    }
    
}
