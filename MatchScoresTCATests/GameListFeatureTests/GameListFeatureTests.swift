//
//  GameListFeatureTests.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 1.12.2023.
//

import XCTest
import ComposableArchitecture
@testable import MatchScoresTCA

let testGameUUID = UUID(uuidString: "C2A248E6-5CDD-4536-A54C-8E616DB50774")

@MainActor
final class GameListFeatureTests: XCTestCase {
    
    func testSearchAndClearQuery() async {
        let store = TestStore(
            initialState: GameListFeature.State()) {
                GameListFeature()
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
    
    func testGetGames() async {
        let store = TestStore(initialState: GameListFeature.State()) {
            GameListFeature()
        } withDependencies: {
            $0.matchScoresClient.fetchGames = { GamesModel.mockGameModel }
        }
        
        await store.send(.onAppear) {
            $0.isLoading = true
            $0.dataLoadingStatus = .loading
        }
        
        await store.receive(.fetchGameResponse(.success(GamesModel.mockGameModel))) {
            $0.dataLoadingStatus = .loading
            $0.isLoading = false
            $0.totalPages = GamesModel.mockGameModel.meta.totalCount
            $0.gamesData = GamesModel.mockGameModel.data
            $0.gameList += IdentifiedArrayOf(uniqueElements: GamesModel.mockGameModel.data)
        }
    }
}
