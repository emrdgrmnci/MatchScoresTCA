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
        var results: [PlayerData] = []
        var resultPlayerRequestInFlight: PlayersModel?
        var playerList: IdentifiedArrayOf<PlayerFeature.State> = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
    }
    
    enum Action: Equatable {
//        case fetchPlayers
        case fetchPlayerResponse(TaskResult<PlayersModel>)
        case player(id: PlayerFeature.State.ID, action: PlayerFeature.Action)
        case onAppear
        
    }
    
    var uuid: @Sendable () -> UUID
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .fetchPlayerResponse(.failure(let error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting products, try again later.")
            return .none
            
        case let .fetchPlayerResponse(.success(playerData)):
            state.playerList = IdentifiedArrayOf(
                uniqueElements: playerData.data.map {
                    PlayerFeature.State(
                        id: uuid(),
                        player: $0
                    )
                }
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
        case .player:
            return .none
        }
    }
}

/*
 Reducer/Feature that contains the state and handles actions for 3 separate screens (Teams, Players, Favorites). These would be the next logical steps:
 Create an explicit Action and State  for each screen
 */

/*
 case .fetchProducts:
 if state.dataLoadingStatus == .success || state.dataLoadingStatus == .loading {
 return .none
 }
 
 state.dataLoadingStatus = .loading
 return .task {
 await .fetchProductsResponse(
 TaskResult { try await fetchProducts() }
 )
 }
 case .fetchProductsResponse(.success(let products)):
 state.dataLoadingStatus = .success
 state.productList = IdentifiedArrayOf(
 uniqueElements: products.map {
 ProductDomain.State(
 id: uuid(),
 product: $0
 )
 }
 )
 return .none
 case .fetchProductsResponse(.failure(let error)):
 state.dataLoadingStatus = .error
 print(error)
 print("Error getting products, try again later.")
 return .none
 */
