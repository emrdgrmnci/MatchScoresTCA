//
//  GameListFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct GameListFeature: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var gameList: IdentifiedArrayOf<GameData> = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
    }
    
    enum Action: Equatable {
        case fetchGameResponse(TaskResult<GamesModel>)
        case onAppear
    }
    
    var uuid: @Sendable () -> UUID
    private enum CancelID { case game }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .fetchGameResponse(.failure(error)):
            state.dataLoadingStatus = .error
            print(error)
            print("DEBUG: Error getting games, try again later.")
            return .none
            
        case let .fetchGameResponse(.success(gameData)):
            state.gameList = IdentifiedArrayOf(uniqueElements: gameData.data
            )
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppear:
            return .run { send in
                await send (
                    .fetchGameResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchGames()
                        }
                    )
                )
            }
        }
    }
}
