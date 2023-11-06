//
//  StatsNetworkingEndpointTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 12.10.2023.
//

import XCTest
@testable import MatchScoresTCA

final class StatsNetworkingEndpointTests: XCTestCase {
    func test_with_stats_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.stats("1")
        
        XCTAssertEqual(endpoint.host, "www.balldontlie.io", "The host should be balldontlie.io")
        XCTAssertEqual(endpoint.path, "/api/v1/stats", "The path should be /api/v1/stats")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        if let playerId = "1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "https://balldontlie.io/api/v1/stats?player_ids[\(playerId)]=1"
            if let url = URL(string: urlString) {
                XCTAssertEqual(url.absoluteString, "https://balldontlie.io/api/v1/stats?player_ids%5B1%5D=1", "The generated URL doesn't match our endpoint")
            }
        }
    }
}
