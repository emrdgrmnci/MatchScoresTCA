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
            $0.dataLoadingStatus = .loading
            $0.isLoading = true
            $0.searchQuery = "S"
        }
        await store.send(.searchQueryChanged("")) {
            $0.isLoading = false
            $0.searchQuery = ""
        }
    }
    
    func testGetPlayers() async {
        let store = TestStore(initialState: PlayerListFeature.State()) {
            PlayerListFeature()
        } withDependencies: {
            $0.matchScoresClient.fetchPlayers = { _ in PlayersModel.sample
            }
        }
        
        await store.send(.onAppear) {
            $0.isLoading = true
            $0.dataLoadingStatus = .loading
        }
        
        await store.receive(.fetchPlayerResponse(.success(PlayersModel.sample))) {
            $0.dataLoadingStatus = .loading
            $0.isLoading = false
            $0.totalPages = PlayersModel.sample.meta.totalCount
            $0.playersData = PlayersModel.sample.data
            $0.playerList += IdentifiedArrayOf(uniqueElements: PlayersModel.sample.data.sorted(by: >))
        }
    }
}
