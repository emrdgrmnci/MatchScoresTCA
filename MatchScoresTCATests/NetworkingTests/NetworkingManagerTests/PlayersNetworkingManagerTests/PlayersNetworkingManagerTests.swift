//
//  PlayersNetworkingManagerTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class PlayersNetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var playersUrl: URL!
    
    override func setUp() {
        playersUrl = URL(string: "https://www.balldontlie.io/api/v1/players")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        playersUrl = nil
    }
    
    func test_with_valid_json_successfully_decodes() async throws {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "PlayersStaticData", type: PlayersModel.self), "Mapper shouldn't throw and error")
        
        let playersResponse = try? StaticJSONMapper.decode(file: "PlayersStaticData", type: PlayersModel.self)
        XCTAssertNotNil(playersResponse, "Teams response shouldn't be nil")
        
        XCTAssertEqual(playersResponse?.meta.totalPages, 206, "Total pages should be 206")
        XCTAssertEqual(playersResponse?.meta.currentPage, 1, "Current page should be 1")
        XCTAssertEqual(playersResponse?.meta.nextPage, 2, "Next page page should be 2")
        XCTAssertEqual(playersResponse?.meta.perPage, 25, "Page number should be 25")
        XCTAssertEqual(playersResponse?.meta.totalCount, 5130, "Total page count should be 5130")
        XCTAssertEqual(playersResponse?.data[0].id, 14, "Player ID should be 14")
        XCTAssertEqual(playersResponse?.data[0].firstName, "Ike", "Player name should be Ike")
        XCTAssertEqual(playersResponse?.data[0].lastName, "Anigbogu", "Player last name should be Anigbogu")
        XCTAssertEqual(playersResponse?.data[0].position, "C", "Player position should be 'C'")
        XCTAssertEqual(playersResponse?.data[0].team.id, 12, "Player team ID should be 12")
        XCTAssertEqual(playersResponse?.data[0].team.abbreviation, "IND", "Player team abbreviation should be IND")
        XCTAssertEqual(playersResponse?.data[0].team.city, "Indiana", "Player team city should be Indiana")
        XCTAssertEqual(playersResponse?.data[0].team.conference, "East", "Player team conference should be East")
        XCTAssertEqual(playersResponse?.data[0].team.division, "Central", "Player team division should be Central")
        XCTAssertEqual(playersResponse?.data[0].team.fullName, "Indiana Pacers", "Player team full name should be Indiana Pacers")
        XCTAssertEqual(playersResponse?.data[0].team.name, "Pacers", "Player team full name should be Pacers")
    }
    
    func test_with_players_model_equal(_ model1: PlayersModel, _ model2: PlayersModel) async throws {
        XCTAssertEqual(model1.meta, model2.meta, "Meta data should be equal")
        XCTAssertEqual(model1.data.count, model2.data.count, "Number of teams should be equal")
        
        for (player1, player2) in zip(model1.data, model2.data) {
            XCTAssertEqual(player1, player2, "Player data should be equal")
        }
    }
    
    func test_with_players_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.playersUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .players(page: 1))
    }
    
    func test_with_players_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.playersUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .players(page: 1),
                                                           type: PlayersModel.self)
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
    
    func test_with_players_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.playersUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .players(page: 1))
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
