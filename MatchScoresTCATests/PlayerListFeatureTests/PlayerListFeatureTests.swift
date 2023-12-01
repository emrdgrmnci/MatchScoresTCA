//
//  PlayerListFeatureTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 1.12.2023.
//

import XCTest
import ComposableArchitecture

@testable import MatchScoresTCA

let testPlayerUUID = UUID(uuidString: "456FC1A-1A57-4FE9-8754-693CA1678974")!

@MainActor
final class PlayerListFeatureTests: XCTestCase {
    
    func testSearchAndClearQuery() async {
        let store = TestStore(
            initialState: PlayerListFeature.State()) {
                PlayerListFeature()
            }
        await store.send(.searchQueryChanged("S")) {
            $0.searchQuery = "S"
        }
        await store.send(.searchQueryChanged("")) {
            $0.searchQuery = ""
        }
    }
}
    
//    func testGetPlayers() async {
//        let mockResponse = PlayersModel(
//            data: [
//                PlayerData(
//                    id: 14,
//                    firstName: "Ike",
//                    heightFeet: nil,
//                    heightInches: nil,
//                    lastName: "Anigbogu",
//                    position: "C",
//                    team:
//                        TeamData(
//                            id: 12,
//                            abbreviation: "IND",
//                            city: "Indiana",
//                            conference: "East",
//                            division: "Central",
//                            fullName: "Indiana Pacers",
//                            name: "Pacers"),
//                    weightPounds: nil
//                ),
//                
//                PlayerData(
//                    id: 25,
//                    firstName: "Ron",
//                    heightFeet: nil,
//                    heightInches: nil,
//                    lastName: "Baker",
//                    position: "G",
//                    team:
//                        TeamData(
//                            id: 20,
//                            abbreviation: "NYK",
//                            city: "New York",
//                            conference: "West",
//                            division: "Atlantic",
//                            fullName: "New York Knicks",
//                            name: "Knicks"),
//                    weightPounds: nil
//                ),
//                
//                PlayerData(
//                    id: 47,
//                    firstName: "Jabari",
//                    heightFeet: nil,
//                    heightInches: nil,
//                    lastName: "Bird",
//                    position: "G",
//                    team:
//                        TeamData(
//                            id: 15,
//                            abbreviation: "MEM",
//                            city: "Memphis",
//                            conference: "West",
//                            division: "Southwest",
//                            fullName: "Memphis Grizzlies",
//                            name: "Grizzlies"),
//                    weightPounds: nil)
//            ], meta:
//                Meta(
//                    totalPages: 206,
//                    currentPage: 1,
//                    nextPage: 2,
//                    perPage: 25,
//                    totalCount: 5130
//                )
//        )
//        
//        let store = TestStore(initialState: PlayerListFeature.State()) {
//            PlayerListFeature()
//        } withDependencies: {
//            $0.matchScoresClient.fetchPlayers = { _ in
//                return mockResponse
//            }
//        }
//        
//        await store.send(.onAppearPlayer) {
//            $0.dataLoadingStatus = .loading
//        }
//        
//        await store.receive(.fetchPlayerResponse(TaskResult.success(mockResponse))) {
//            $0.playersData = mockResponse.data
//            $0.playerList = IdentifiedArrayOf(uniqueElements:
//                                                mockResponse.data.sorted(by: >))
//            $0.totalPages = mockResponse.meta.totalCount
//            $0.dataLoadingStatus = .loading
//        }
//    }
