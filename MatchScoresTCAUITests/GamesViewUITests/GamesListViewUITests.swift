//
//  GamesListViewUITests.swift
//  MatchScoresTCAUITests
//
//  Created by Emre on 26.11.2023.
//

import XCTest

final class GamesListViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITesting"]
        app.launch()
    }
    
    func testGamesSearchFunctionality() throws {
         app.tabBars.buttons["Games"].tap()
        
        // Interact with Search Field
        let searchField = app.searchFields["Search All NBA Competitions"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.tap()
        searchField.typeText("Lakers")
        
        // Wait for search results to load
        let expectation = XCTestExpectation(description: "Wait for search results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6)
        
        // Verify if a specific game appears in the search results
        let specificGame = app.staticTexts["Lakers"]
        XCTAssertTrue(specificGame.exists, "Expected game not found in search results")
    }
}

