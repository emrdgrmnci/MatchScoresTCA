//
//  MatchScoresClient.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation
import ComposableArchitecture

struct MatchScoresClient {
    var fetchTeams: () async throws -> Teams
}
extension MatchScoresClient: DependencyKey {
    static let liveValue = Self( fetchTeams: {
        
        let (data, _) = try await URLSession.shared.data(
            from: URL(string: "https://www.balldontlie.io/api/v1/teams")!
        )
        let teams = try JSONDecoder().decode(Teams.self, from: data)
        return teams
    }
    )
}
extension DependencyValues {
    var matchScore: MatchScoresClient {
        get { self[MatchScoresClient.self] }
        set { self[MatchScoresClient.self] = newValue }
    }
}
