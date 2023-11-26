//
//  PlayerListViewUITests.swift
//  MatchScoresTCAUITests
//
//  Created by Emre on 26.11.2023.
//

import XCTest

final class PlayerListViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITesting"]
        app.launch()
    }
    
    func testPlayerSearchFunctionality() throws {
        // Navigate to Players View
        app.tabBars.buttons["Players"].tap()

        // Interact with Search Field
        let searchField = app.searchFields["Search NBA Players"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.tap()
        searchField.typeText("Alex Abrines")

        // Use NSPredicate to wait for search results
        let predicate = NSPredicate(format: "exists == true")
        let playerGrid = app.otherElements["playerGrid"]
        let playerGridExpectation = XCTNSPredicateExpectation(predicate: predicate, object: playerGrid)
        
        // Verify grid appears with search results
        let result = XCTWaiter.wait(for: [playerGridExpectation], timeout: 10) // Adjust timeout as needed
        XCTAssertEqual(result, .completed, "Grid for displaying players did not load in time")
    }
}
