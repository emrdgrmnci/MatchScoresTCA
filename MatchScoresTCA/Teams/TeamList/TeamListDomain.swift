//
//  TeamListDomain.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation
import ComposableArchitecture

struct MatchFeature: Reducer {
    struct State: Equatable {
        var team: Teams?
        var isLoadingTeam = false
    }
    enum Action: Equatable {
        case teamResponse(Teams)
        case teamsDataLoaded
    }
    @Dependency(\.matchScore) var numberFact
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .teamResponse(fact):
                state.team = fact
                state.isLoadingTeam = false
                return .none
                
            case .teamsDataLoaded:
                state.team = nil
                state.isLoadingTeam = true
                return .run { send in
                    try await send(.teamResponse(self.numberFact.fetchTeams()))
                }
            }
        }
    }
}
