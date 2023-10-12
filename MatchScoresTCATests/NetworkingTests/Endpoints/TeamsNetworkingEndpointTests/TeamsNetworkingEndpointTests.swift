//
//  TeamsNetworkingEndpointTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class TeamsNetworkingEndpointTests: XCTestCase {
    
    func test_with_teams_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.teams
        
        XCTAssertEqual(endpoint.host, "www.balldontlie.io", "The host should be balldontlie.io")
        XCTAssertEqual(endpoint.path, "/api/v1/teams", "The path should be /api/v1/teams")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.balldontlie.io/api/v1/teams?", "The generated URL doesn't match our endpoint")
    }
}
