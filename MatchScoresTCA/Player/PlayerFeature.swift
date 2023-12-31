//
//  PlayerFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 7.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct PlayerFeature: Reducer {
    struct State: Equatable, Identifiable {
        let id: UUID
        let player: PlayerData
    }
    
    enum Action: Equatable {
        case onAppear
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        }
    }
}
