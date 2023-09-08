//
//  PlayerFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct PlayerListFeature: Reducer { 
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var playerList: IdentifiedArrayOf<PlayerData> = []
        var searchQuery = ""
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<PlayerData> {
            guard !searchQuery.isEmpty else {
                return playerList
            }
            return playerList.filter { "\($0.firstName)\($0.lastName)".lowercased().contains(searchQuery.lowercased())
            }
        }
        
    }
    
    enum Action: Equatable {
        case fetchPlayerResponse(TaskResult<PlayersModel>)
        case searchQueryChanged(String)
        case onAppear
    }
    
    var uuid: @Sendable () -> UUID
    
    private enum CancelID { case player }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .fetchPlayerResponse(.failure(let error)):
            state.dataLoadingStatus = .error
            print(error)
            print("DEBUG: getting players, try again later.")
            return .none
            
        case let .fetchPlayerResponse(.success(playerData)):
            state.playerList = IdentifiedArrayOf(
                uniqueElements: playerData.data
            )
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppear:
            return .run { send in
                await send (
                    .fetchPlayerResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchPlayers()
                        }
                    )
                )
            }
            
        case let .searchQueryChanged(query):
            state.searchQuery = query
            guard !query.isEmpty else {
                return .cancel(id: CancelID.player)
            }
            return .none
        }
    }
}
