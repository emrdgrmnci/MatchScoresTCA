//
//  GamesNetworkingManagerTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class GamesNetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var gamesUrl: URL!
    
    override func setUp() {
        gamesUrl = URL(string: "https://balldontlie.io/api/v1/games")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        gamesUrl = nil
    }
    
    func test_with_valid_games_json_successfully_decodes() async throws {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "GamesStaticData", type: GamesModel.self), "Mapper shouldn't throw and error")
        
        let gamesResponse = try? StaticJSONMapper.decode(file: "GamesStaticData", type: GamesModel.self)
        XCTAssertNotNil(gamesResponse, "Games response shouldn't be nil")
        
        XCTAssertEqual(gamesResponse?.meta.totalPages, 2818, "Total pages should be 2")
        XCTAssertEqual(gamesResponse?.meta.currentPage, 1, "Current page should be 1")
        XCTAssertEqual(gamesResponse?.meta.nextPage, 2, "Next page page should be 2")
        XCTAssertEqual(gamesResponse?.meta.perPage, 25, "Page number should be 30")
        XCTAssertEqual(gamesResponse?.meta.totalCount, 70448, "Total page count should be 45")
    }
    
    func test_with_games_model_equal(_ model1: GamesModel, _ model2: GamesModel) async throws {
        XCTAssertEqual(model1.meta, model2.meta, "Meta data should be equal")
        XCTAssertEqual(model1.data.count, model2.data.count, "Number of games should be equal")

        for (team1, team2) in zip(model1.data, model2.data) {
            XCTAssertEqual(team1, team2, "Game data should be equal")
        }
    }
    
    func test_with_games_successful_response_response_is_valid() async throws {
        guard let path = Bundle.main.path(forResource: "GamesStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.gamesUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session,
                                                             .games,
                                                             type: GamesModel.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "GamesStaticData", type: GamesModel.self)
        
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
    }
    
    func test_with_games_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.gamesUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .games)
    }
    
    func test_with_games_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.gamesUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .games,
                                                           type: GamesModel.self)
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
    
    func test_with_games_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.gamesUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .games)
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
