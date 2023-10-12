//
//  TeamsScreenUITest.swift
//  MatchScoresTCAUITests
//
//  Created by emre.degirmenci on 12.10.2023.
//

import XCTest

final class TeamsScreenUITest: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp(){
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success": "1"]
        app.launch()
    }

    override func tearDown() {
        app = nil
    }
}
