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
//    var search: @Sendable (String) async throws -> TeamsModel
    var fetchPlayers: @Sendable () async throws -> PlayersModel
}
extension MatchScoresClient: DependencyKey {
    static let liveValue = Self( fetchTeams: {
        
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://www.balldontlie.io/api/v1/teams")!
        )
        let teams = try JSONDecoder().decode(TeamsModel.self, from: data)
        return teams
    },
        fetchPlayers: {
        let (data, _) = try await URLSession.shared
            .data(from: URL(string: "https://www.balldontlie.io/api/v1/players")!)
        let player = try JSONDecoder().decode(PlayersModel.self, from: data)
        return player
    }
    )
}
extension DependencyValues {
    var matchScoresClient: MatchScoresClient {
        get { self[MatchScoresClient.self] }
        set { self[MatchScoresClient.self] = newValue }
    }
}
