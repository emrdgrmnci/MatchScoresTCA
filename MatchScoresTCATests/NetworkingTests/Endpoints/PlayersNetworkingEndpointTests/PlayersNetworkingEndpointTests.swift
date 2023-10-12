//
//  PlayersNetworkingEndpointTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class PlayersNetworkingEndpointTests: XCTestCase {
    
    func test_with_players_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.players
        
        XCTAssertEqual(endpoint.host, "www.balldontlie.io", "The host should be balldontlie.io")
        XCTAssertEqual(endpoint.path, "/api/v1/players", "The path should be /api/v1/players")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.balldontlie.io/api/v1/players?", "The generated URL doesn't match our endpoint")
    }
}
