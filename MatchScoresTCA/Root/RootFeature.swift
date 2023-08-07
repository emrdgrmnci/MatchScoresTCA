//
//  RootFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import Foundation

struct RootDomain: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamFeature.State()
        var playerListState = PlayerFeature.State()
    }
    
    enum Tab {
        case teams
        case favorites
        case players
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamFeature.Action)
        case playerList(PlayerFeature.Action)
    }
    
    var fetchTeams: @Sendable () async throws -> [Datum]
    var fetchPlayers:  @Sendable () async throws -> [PlayerData]
    var uuid: @Sendable () -> UUID
    
    static let live = Self(
        fetchTeams: MatchScoresClient.liveValue.fetchTeams,
        fetchPlayers: MatchScoresClient.liveValue.fetchPlayers,
        uuid: { UUID() }
    )
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .teamList:
                return .none
            case .playerList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
        Scope(state: \.teamListState, action: /RootDomain.Action.teamList) {
            TeamFeature()
        }
        Scope(state:  \.playerListState, action: /RootDomain.Action.playerList) {
            PlayerFeature()
        }
    }
}
