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
