//
//  MatchScoresClient.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation
import ComposableArchitecture

struct MatchScoresClient {
    var fetchTeams: @Sendable (Int) async throws -> TeamsModel
    var fetchPlayers: @Sendable (Int) async throws -> PlayersModel
    var fetchGames: @Sendable () async throws -> GamesModel
    var fetchStats: (String) async throws -> StatsModel
    var error: NetworkingManager.NetworkingError?
}

extension MatchScoresClient: DependencyKey {
    static let liveValue = Self(
        fetchTeams: { page in
            let response = try await NetworkingManager.shared.request(session: .shared, .teams(page: page), type: TeamsModel.self)
            return response
        },
        fetchPlayers: { page in 
            let response = try await NetworkingManager.shared.request(session: .shared, .players(page: page), type: PlayersModel.self)
            return response
        },
        fetchGames: {
            let response = try await NetworkingManager.shared.request(session: .shared, .games, type: GamesModel.self)
            return response
        },
        fetchStats: { playerID in
            let response = try await
            NetworkingManager.shared.request(session: .shared, .stats(playerID), type: StatsModel.self)
            return response
        }
    )
}
extension DependencyValues {
    var matchScoresClient: MatchScoresClient {
        get { self[MatchScoresClient.self] }
        set { self[MatchScoresClient.self] = newValue }
    }
}
