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
        app.tabBars.buttons["Players"].tap()

        // Interact with Search Field
        let searchField = app.searchFields["Search NBA Players"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.tap()
        searchField.typeText("Victor Alexander")

        let predicate = NSPredicate(format: "exists == true")
        let playerGrid = app.otherElements["playerGrid"]
        let playerGridExpectation = XCTNSPredicateExpectation(predicate: predicate, object: playerGrid)
        
        // Verify grid appears with search results
        let result = XCTWaiter.wait(for: [playerGridExpectation], timeout: 10)
        XCTAssertEqual(result, .completed, "Grid for displaying players did not load in time")
        
        // Verify if a specific player appears in the search results
        let specificPlayer = app.staticTexts["Victor Alexander"]
        XCTAssertTrue(specificPlayer.exists, "Expected player not found in search results")
        
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.exists, "Cancel button does not exist")
                cancelButton.tap()
    }
}
