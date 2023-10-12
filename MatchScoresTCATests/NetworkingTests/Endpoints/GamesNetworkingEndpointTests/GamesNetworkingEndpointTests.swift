//
//  GamesNetworkingEndpointTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class GamesNetworkingEndpointTests: XCTestCase {
    
    func test_with_games_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.games
        
        XCTAssertEqual(endpoint.host, "www.balldontlie.io", "The host should be balldontlie.io")
        XCTAssertEqual(endpoint.path, "/api/v1/games", "The path should be /api/v1/games")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.balldontlie.io/api/v1/games?", "The generated URL doesn't match our endpoint")
    }
}
