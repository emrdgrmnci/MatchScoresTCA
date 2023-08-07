//
//  TeamFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct TeamFeature: Reducer {
    struct State: Equatable {
        var results: [Datum] = []
        var resultTeamRequestInFlight: Datum?
    }
    
    enum Action: Equatable {
        case teamResponse(Datum.ID, TaskResult<Datum>)
        case onAppear(Datum)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .teamResponse(_, .failure):
            state.resultTeamRequestInFlight = nil
            return .none
        case let .teamResponse(_, .success(teamData)):
            state.resultTeamRequestInFlight = teamData
            return .none
        case let .onAppear(datum):
            state.resultTeamRequestInFlight = datum
            return .none
        }
    }
}
