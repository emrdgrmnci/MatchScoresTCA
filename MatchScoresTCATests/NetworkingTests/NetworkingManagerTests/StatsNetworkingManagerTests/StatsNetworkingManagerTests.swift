//
//  StatsNetworkingManagerTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 12.10.2023.
//

import XCTest
@testable import MatchScoresTCA

final class StatsNetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var statsUrl: URL!
    
    override func setUp() {
        statsUrl = URL(string: "https://balldontlie.io/api/v1/stats?player_ids[]=1")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }

    override func tearDown() {
        session = nil
        statsUrl = nil
    }

    func test_with_valid_json_successfully_decodes() async throws {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "StatsStaticData", type: StatsModel.self), "Mapper shouldn't throw and error")
        
        let statsResponse = try? StaticJSONMapper.decode(file: "StatsStaticData", type: StatsModel.self)
        XCTAssertNotNil(statsResponse, "Stats response shouldn't be nil")
        
        XCTAssertEqual(statsResponse?.meta?.totalPages, 9, "Total pages should be 9")
        XCTAssertEqual(statsResponse?.meta?.currentPage, 1, "Current page should be 1")
        XCTAssertEqual(statsResponse?.meta?.nextPage, 2, "Next page should be 2")
        XCTAssertEqual(statsResponse?.meta?.perPage, 25, "Per page should be 25")
        XCTAssertEqual(statsResponse?.meta?.totalCount, 207, "Total pages count should be 207")
        
    }

    func stats_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.statsUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .stats("1"))
    }
    
    func test_with_stats_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.statsUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .stats("1"),
                                                           type: StatsModel.self)
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
    func test_with_stats_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.statsUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .stats("1"))
        } catch {
            
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingManager.NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
}
