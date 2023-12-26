//
//  TeamsNetworkingManagerTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 29.09.2023.
//

import XCTest
@testable import MatchScoresTCA

final class TeamsNetworkingManagerTests: XCTestCase {
    private var session: URLSession!
    private var teamsUrl: URL!
    
    override func setUp() {
        teamsUrl = URL(string: "https://www.balldontlie.io/api/v1/teams")
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        teamsUrl = nil
    }
    
    func test_with_valid_json_successfully_decodes() async throws {
        XCTAssertNoThrow(
            try StaticJSONMapper.decode(file: "TeamsStaticData", type: TeamsModel.self),
            "Mapper shouldn't throw and error"
        )
        
        let teamsResponse = try? StaticJSONMapper.decode(file: "TeamsStaticData", type: TeamsModel.self)
        XCTAssertNotNil(teamsResponse, "Teams response shouldn't be nil")
        
        XCTAssertEqual(teamsResponse?.meta.totalPages, 2, "Total pages should be 2")
        XCTAssertEqual(teamsResponse?.meta.currentPage, 1, "Current page should be 1")
        XCTAssertEqual(teamsResponse?.meta.nextPage, 2, "Next page page should be 2")
        XCTAssertEqual(teamsResponse?.meta.perPage, 30, "Page number should be 30")
        XCTAssertEqual(teamsResponse?.meta.totalCount, 45, "Total page count should be 45")
        
        XCTAssertEqual(teamsResponse?.data[0].id, 1, "Team ID should be 1")
        XCTAssertEqual(teamsResponse?.data[0].abbreviation, "ATL", "Team Abbreviation should be ATL")
        XCTAssertEqual(teamsResponse?.data[0].city, "Atlanta", "City should be Atlanta")
        XCTAssertEqual(teamsResponse?.data[0].conference, "East", "Conference should be East")
        XCTAssertEqual(teamsResponse?.data[0].division, "Southeast", "Division should be Southeast")
        XCTAssertEqual(teamsResponse?.data[0].fullName, "Atlanta Hawks", "Team full name should be Atlanta Hawks")
        XCTAssertEqual(teamsResponse?.data[0].name, "Hawks", "Team name should be Hawks")
        
        XCTAssertEqual(teamsResponse?.data[1].id, 2, "Team ID should be 2")
        XCTAssertEqual(teamsResponse?.data[1].abbreviation, "BOS", "Team Abbreviation should be BOS")
        XCTAssertEqual(teamsResponse?.data[1].city, "Boston", "City should be Boston")
        XCTAssertEqual(teamsResponse?.data[1].conference, "East", "Conference should be East")
        XCTAssertEqual(teamsResponse?.data[1].division, "Atlantic", "Division should be Atlantic")
        XCTAssertEqual(teamsResponse?.data[1].fullName, "Boston Celtics", "Team full name should be Boston Celtics")
        XCTAssertEqual(teamsResponse?.data[1].name, "Celtics", "Team name should be Celtics")
        
        XCTAssertEqual(teamsResponse?.data[2].id, 3, "Team ID should be 3")
        XCTAssertEqual(teamsResponse?.data[2].abbreviation, "BKN", "Team Abbreviation should be BKN")
        XCTAssertEqual(teamsResponse?.data[2].city, "Brooklyn", "City should be Brooklyn")
        XCTAssertEqual(teamsResponse?.data[2].conference, "East", "Conference should be East")
        XCTAssertEqual(teamsResponse?.data[2].division, "Atlantic", "Division should be Atlantic")
        XCTAssertEqual(teamsResponse?.data[2].fullName, "Brooklyn Nets", "Team full name should be Brooklyn Nets")
        XCTAssertEqual(teamsResponse?.data[2].name, "Nets", "Team name should be Nets")
    }
    
    func test_with_teams_model_equal(_ model1: TeamsModel, _ model2: TeamsModel) async throws {
        XCTAssertEqual(model1.meta, model2.meta, "Meta data should be equal")
        XCTAssertEqual(model1.data.count, model2.data.count, "Number of teams should be equal")
        
        for (team1, team2) in zip(model1.data, model2.data) {
            XCTAssertEqual(team1, team2, "Team data should be equal")
        }
    }
    
    func test_with_teams_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.teamsUrl,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        _ = try await NetworkingManager.shared.request(session: session, .teams(page: 1))
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
            _ = try await NetworkingManager.shared.request(
                session: session,
                .teams(page: 1),
                type: TeamsModel.self
            )
        } catch {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(
                networkingError,
                NetworkingManager.NetworkingError.invalidStatusCode(
                    statusCode: invalidStatusCode
                ),
                "Error should be a networking error which throws an invalid status code"
            )
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
                                                           .teams(page: 1))
        } catch {
            guard let networkingError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            XCTAssertEqual(
                networkingError,
                NetworkingManager.NetworkingError.invalidStatusCode(
                    statusCode: invalidStatusCode
                ),
                "Error should be a networking error which throws an invalid status code"
            )
        }
    }
}
