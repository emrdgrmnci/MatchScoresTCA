//
//  NetworkingEndpointTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 15.09.2023.
//

import XCTest
@testable import MatchScoresTCA

class NetworkingEndpointTests: XCTestCase {

    func test_with_teams_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.teams
        
        XCTAssertEqual(endpoint.host, "www.balldontlie.io", "The host should be balldontlie.io")
        XCTAssertEqual(endpoint.path, "/api/v1/teams", "The path should be /api/v1/teams")
        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://www.balldontlie.io/api/v1/teams?delay=2", "The generated doesn't match our endpoint")
    }
    
//    func test_with_detail_endpoint_request_is_valid() {
//
//        let userId = 1
//        let endpoint = Endpoint.detail(id: userId)
//
//        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
//        XCTAssertEqual(endpoint.path, "/api/users/\(userId)", "The path should be /api/users/\(userId)")
//        XCTAssertEqual(endpoint.methodType, .GET, "The method type should be GET")
//        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
//
//        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userId)?delay=2", "The generated doesn't match our endpoint")
//
//    }
    
//    func test_with_create_endpoint_request_is_valid() {
//
//        let endpoint = Endpoint.create(submissionData: nil)
//        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
//        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
//        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method type should be POST")
//        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
//
//        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=2", "The generated doesn't match our endpoint")
//
//    }
}
