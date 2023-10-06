//
//  MatchScoresClient.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation
import ComposableArchitecture

struct MatchScoresClient {
    var fetchTeams: () async throws -> TeamsModel
    var fetchPlayers: () async throws -> PlayersModel
    var fetchGames: () async throws -> GamesModel
    var fetchStats: () async throws -> StatsModel
    var error: NetworkingManager.NetworkingError?
}

extension MatchScoresClient: DependencyKey {
    static let liveValue = Self(
        fetchTeams: {
            let response = try await NetworkingManager.shared.request(session: .shared, .teams, type: TeamsModel.self)
            return response
        },
        fetchPlayers: {
            let response = try await NetworkingManager.shared.request(session: .shared, .players, type: PlayersModel.self)
            return response
        },
        fetchGames: {
            let response = try await NetworkingManager.shared.request(session: .shared, .games, type: GamesModel.self)
            return response
        },
        fetchStats: {
            let response = try await
            NetworkingManager.shared.request(session: .shared, .stats, type: StatsModel.self)
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
