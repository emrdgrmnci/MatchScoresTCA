//
//  TeamListViewUITests.swift
//  MatchScoresTCAUITests
//
//  Created by Emre on 26.11.2023.
//

import XCTest

final class TeamListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITesting"]
        app.launch()
    }
    
    func testTeamSearchFunctionality() throws {
        // Navigate to Teams View if necessary
        app.tabBars.buttons["Teams"].tap()
        
        // Interact with Search Field
        let searchField = app.searchFields["Search NBA Teams"]
        XCTAssertTrue(searchField.exists, "Search field does not exist")
        searchField.tap()
        searchField.typeText("Lakers")
        
        // Wait for search results to load
        let expectation = XCTestExpectation(description: "Wait for search results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Adjust time as needed
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 6)
        
        // Verify Search Results
        // Assuming the search results are displayed in a grid with accessibility identifier 'peopleGrid'
        let teamsGrid = app.otherElements["teamsGrid"]
        XCTAssertTrue(teamsGrid.exists, "Grid for displaying teams does not exist")
        
        // Verify if a specific team appears in the search results
        let specificTeam = app.staticTexts["Lakers"] // Adjust according to how teams are displayed
        XCTAssertTrue(specificTeam.exists, "Expected team not found in search results")
    }
}
