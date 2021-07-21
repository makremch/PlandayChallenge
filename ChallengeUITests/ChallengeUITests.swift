//
//  ChallengeUITests.swift
//  ChallengeUITests
//
//  Created by Makrem Hammani on 18/7/2021.
//

import XCTest

class ChallengeUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        try testingNavigationBar()
        try testingNavigationAllButton()
        try testingNavigationCovidButton()
        try testingNavigationSportButton()
        try testingList()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testingNavigationBar() throws {
        let app = XCUIApplication()
        app.launch()
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
    }
    
    func testingNavigationAllButton() throws {
        let app = XCUIApplication()
        app.launch()
        let all = app.buttons["All"]
        XCTAssert(all.exists)
        XCTAssertEqual(all.label, "All")
    }
    
    func testingNavigationCovidButton() throws {
        let app = XCUIApplication()
        app.launch()
        let all = app.buttons["#COVID"]
        XCTAssert(all.exists)
        XCTAssertEqual(all.label, "#COVID")
    }
    
    func testingNavigationSportButton() throws {
        let app = XCUIApplication()
        app.launch()
        let all = app.buttons["#SPORT"]
        XCTAssert(all.exists)
        XCTAssertEqual(all.label, "#SPORT")
    }
    
    func testingList() throws {
        let app = XCUIApplication()
        app.launch()
        let all = app.scrollViews["newsList"]
        XCTAssert(all.exists)
    }
    
    
    
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
