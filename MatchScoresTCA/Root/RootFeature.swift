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
        var statsListState = StatsListFeature.State()
    }
    
    enum Tab {
        case stats
        case teams
        case games
        case players
        case favorites
    }
    
    enum Action: Equatable {
        case tabSelected(Tab)
        case statsList(StatsListFeature.Action)
        case teamList(TeamListFeature.Action)
        case gameList(GameListFeature.Action)
        case playerList(PlayerListFeature.Action)
    }
    
    var fetchStats: () async throws -> StatsModel
    var fetchTeams: () async throws -> TeamsModel
    var fetchGames: () async throws -> GamesModel
    var fetchPlayers:  @Sendable () async throws -> PlayersModel
    var uuid: @Sendable () -> UUID
    
    static let live = Self(
        fetchStats: MatchScoresClient.liveValue.fetchStats,
        fetchTeams: MatchScoresClient.liveValue.fetchTeams,
        fetchGames: MatchScoresClient.liveValue.fetchGames,
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
            case .gameList:
                return .none
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            case .statsList:
                return .none
            }
        }
        Scope(state: \.statsListState, action: /RootFeature.Action.statsList) {
            StatsListFeature(uuid: uuid)
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
