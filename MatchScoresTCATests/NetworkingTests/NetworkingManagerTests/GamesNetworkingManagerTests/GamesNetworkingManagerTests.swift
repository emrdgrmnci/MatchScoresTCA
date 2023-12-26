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
        
        XCTAssertEqual(gamesResponse?.data[0].id, 47179, "Game ID should be 47179")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.id, 2, "Home team ID should be 2")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.abbreviation, "BOS", "Home team should be BOS")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.city, "Boston", "Home team city should be Boston")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.conference, "East", "Home team conference should be East")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.division, "Atlantic", "Home team division should be Atlantic")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.fullName, "Boston Celtics", "Home team full name should be Boston Celtics")
        XCTAssertEqual(gamesResponse?.data[0].homeTeam.name, "Celtics", "Home team name should be Celtics")
        XCTAssertEqual(gamesResponse?.data[0].homeTeamScore, 126, "Home team score should be 126")
        XCTAssertEqual(gamesResponse?.data[0].period, 4, "Period should be 4")
        XCTAssertEqual(gamesResponse?.data[0].postseason, false, "Post season should be 'false'")
        XCTAssertEqual(gamesResponse?.data[0].season, 2018, "Season should be 2018")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.id, 4, "Visitor team ID should be 4")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.abbreviation, "CHA", "Visitor team abbreviation should be CHA")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.city, "Charlotte", "Visitor team city should be Charlotte")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.conference, "East", "Visitor team conference should be East")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.division, "Southeast", "Visitor team division should be Southeast")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.fullName, "Charlotte Hornets", "Visitor team full name should be Charlotte Hornets")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeam.name, "Hornets", "Visitor team name should be Hornets")
        XCTAssertEqual(gamesResponse?.data[0].visitorTeamScore, 94, "Visitor team score should be 94")
        
        
    }
    
    func test_with_games_model_equal(_ model1: GamesModel, _ model2: GamesModel) async throws {
        XCTAssertEqual(model1.meta, model2.meta, "Meta data should be equal")
        XCTAssertEqual(model1.data.count, model2.data.count, "Number of games should be equal")

        for (team1, team2) in zip(model1.data, model2.data) {
            XCTAssertEqual(team1, team2, "Game data should be equal")
        }
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
