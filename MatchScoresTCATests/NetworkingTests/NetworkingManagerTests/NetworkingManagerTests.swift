//
//  NetworkingManagerTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 15.09.2023.
//

import XCTest
@testable import MatchScoresTCA

class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var teamsUrl: URL!
    private var gamesUrl: URL!
    private var playersUrl: URL!
    
    override func setUp() {
        
        teamsUrl = URL(string: "https://www.balldontlie.io/api/v1/teams")
        gamesUrl = URL(string: "https://balldontlie.io/api/v1/games")
        playersUrl = URL(string: "https://balldontlie.io/api/v1/players")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        teamsUrl = nil
        gamesUrl = nil
        playersUrl = nil
    }
    
    func assertTeamsModelEqual(_ model1: TeamsModel, _ model2: TeamsModel) {
        XCTAssertEqual(model1.meta, model2.meta, "Meta data should be equal")
        XCTAssertEqual(model1.data.count, model2.data.count, "Number of teams should be equal")

        for (team1, team2) in zip(model1.data, model2.data) {
            XCTAssertEqual(team1, team2, "Team data should be equal")
        }
    }
    
    func test_with_teams_successful_response_response_is_valid() async throws {
        guard let path = Bundle.main.path(forResource: "TeamsStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.teamsUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session,
                                                             .teams,
                                                             type: TeamsModel.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "TeamsStaticData", type: TeamsModel.self)
        
        assertTeamsModelEqual(res, staticJSON)
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
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
    
    func test_with_players_successful_response_response_is_valid() async throws {
        guard let path = Bundle.main.path(forResource: "PlayersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.playersUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session,
                                                             .players,
                                                             type: PlayersModel.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "PlayersStaticData", type: PlayersModel.self)
        
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
    }
    
    func test_with_teams_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.teamsUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .teams)
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
    
    func test_with_players_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.playersUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .players)
    }
    
    
    func test_with_teams_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.teamsUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .teams,
                                                           type: TeamsModel.self)
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
                                                           .players,
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
    
    func test_with_teams_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.teamsUrl,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session,
                                                           .teams)
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
                                                           .players)
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
    
    //    func test_with_successful_response_with_invalid_json_is_invalid() async {
    //
    //        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
    //              let data = FileManager.default.contents(atPath: path) else {
    //            XCTFail("Failed to get the static users file")
    //            return
    //        }
    //
    //        MockURLSessionProtocol.loadingHandler = {
    //            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
    //            return (response!, data)
    //        }
    //
    //        do {
    //            _ = try await NetworkingManager.shared.request(session: session,
    //                                                           .teams(page: 1),
    //                                                           type: UserDetailResponse.self)
    //        } catch {
    //            if error is NetworkingManager.NetworkingError {
    //                XCTFail("The error should be a system decoding error")
    //            }
    //        }
    //    }
    
