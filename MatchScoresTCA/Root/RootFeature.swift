//
//  RootFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import Foundation

struct RootFeature: Reducer {
    struct State: Equatable {
        var selectedTab = Tab.teams
        var teamListState = TeamListFeature.State()
        var gameListState = GameListFeature.State()
        var playerListState = PlayerListFeature.State()
    }
    
    enum Tab {
        case teams
        case favorites
        case players
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case teamList(TeamListFeature.Action)
        case gameList(GameListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
    
    var fetchTeams: () async throws -> TeamsModel
    var fetchPlayers:  @Sendable () async throws -> PlayersModel
    var fetchGames: () async throws -> GamesModel
    var uuid: @Sendable () -> UUID
    
    static let live = Self(
        fetchTeams: MatchScoresClient.liveValue.fetchTeams,
        fetchPlayers: MatchScoresClient.liveValue.fetchPlayers,
        fetchGames: MatchScoresClient.liveValue.fetchGames,
        uuid: { UUID() }
    )
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .teamList:
                return .none
            case .playerList:
                return .none
            case .gameList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            }
        }
        Scope(state: \.teamListState, action: /RootFeature.Action.teamList) {
            TeamListFeature(uuid: uuid)
        }
        Scope(state: \.gameListState, action: /RootFeature.Action.gameList) {
            GameListFeature(uuid: uuid)
        }
        Scope(state:  \.playerListState, action: /RootFeature.Action.playerList) {
            PlayerListFeature(uuid: uuid)
        }
    }
}
