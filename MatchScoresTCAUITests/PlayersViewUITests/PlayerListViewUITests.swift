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
        searchField.typeText("Alex Abrines")

        let predicate = NSPredicate(format: "exists == true")
        let playerGrid = app.otherElements["playerGrid"]
        let playerGridExpectation = XCTNSPredicateExpectation(predicate: predicate, object: playerGrid)
        
        // Verify grid appears with search results
        let result = XCTWaiter.wait(for: [playerGridExpectation], timeout: 10)
        XCTAssertEqual(result, .completed, "Grid for displaying players did not load in time")
        
        // Verify if a specific player appears in the search results
        let specificTeam = app.staticTexts["Alex Abrines"]
        XCTAssertTrue(specificTeam.exists, "Expected player not found in search results")
    }
}
