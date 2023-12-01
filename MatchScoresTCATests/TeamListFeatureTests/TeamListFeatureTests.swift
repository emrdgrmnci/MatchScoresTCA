//
//  MatchScoresTCATests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 1.12.2023.
//

import XCTest
import ComposableArchitecture
@testable import MatchScoresTCA

let testUUID = UUID(uuidString: "256FB1A-1557-4FE9-9954-693CA1678970")!

@MainActor
final class TeamListFeatureTests: XCTestCase {
    
    func testSearchAndClearQuery() async {
        let store = TestStore(
            initialState: TeamListFeature.State()) {
                TeamListFeature()
            }
        await store.send(.searchQueryChanged("S")) {
            $0.searchQuery = "S"
        }
        await store.send(.searchQueryChanged("")) {
            $0.searchQuery = ""
        }
    }
    
    func testGetTeams() async {
        let mockResponse = TeamsModel(
            id: UUID(uuidString: testUUID)!, // Use a fixed UUID
            data: [
                TeamData(
                    id: 1,
                    abbreviation: "ATL",
                    city: "Atlanta",
                    conference: "East",
                    division: "Southeast",
                    fullName: "Atlanta Hawks",
                    name: "Hawks"
                ),
                TeamData(
                    id: 2,
                    abbreviation: "BOS",
                    city: "Boston",
                    conference: "East",
                    division: "Atlantic",
                    fullName: "Boston Celtics",
                    name: "Celtics"
                ),
                TeamData(
                    id: 3,
                    abbreviation: "BKN",
                    city: "Brooklyn",
                    conference: "East",
                    division: "Atlantic",
                    fullName: "Brooklyn Nets",
                    name: "Nets"
                )
            ],
            meta: Meta(
                totalPages: nil,
                currentPage: 1,
                nextPage: 2,
                perPage: 30,
                totalCount: 45
            )
        )
        
        let store = TestStore(initialState: TeamListFeature.State()) {
            TeamListFeature()
        } withDependencies: {
            $0.matchScoresClient.fetchTeams = { _ in
                return mockResponse
            }
        }
        
        await store.send(.onAppear) {
            $0.dataLoadingStatus = .loading
        }
        
        await store.receive(.fetchTeamResponse(TaskResult.success(mockResponse))) {
            $0.teamsData = mockResponse.data
            $0.teamList = IdentifiedArrayOf(uniqueElements: mockResponse.data.sorted(by: >))
            $0.totalPages = mockResponse.meta.totalCount
            $0.dataLoadingStatus = .loading
        }
    }
}
/*
 This is the problem with use dependencies that talk to the outside world that we cannot control. We simply cannot write a test for this feature because there is no way to predict what the numbers API is going to send back to us.
 
 And really we don’t care about testing the teams API works as expected. That’s an external service that we do not control. For the purpose of this test it would be fine to assume that the teams API works perfectly and sends us back some specific data so that we can then see how that data feeds into the system and affects our feature’s state.
 
 func testGetTeams() async {
 let store = TestStore(initialState: TeamListFeature.State(), reducer: TeamListFeature()) {
 $0.matchScoresClient.fetchTeams = { _ in
 return TaskResult { TeamsModel.sample }
 }
 }
 }
 */
