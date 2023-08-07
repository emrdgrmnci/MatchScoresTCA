//
//  PlayerFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct PlayerFeature: Reducer {
    struct State: Equatable {
        var results: [PlayerData] = []
        var resultPlayerRequestInFlight: PlayerData?
    }
    
    enum Action: Equatable {
        case playerResponse(PlayerData.ID, TaskResult<PlayerData>)
        case onAppear(PlayerData)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .playerResponse(_, .failure):
            state.resultPlayerRequestInFlight = nil
            return .none
        case let .playerResponse(_, .success(playerData)):
            state.resultPlayerRequestInFlight = playerData
            return .none
        case let .onAppear(playerData):
            state.resultPlayerRequestInFlight = playerData
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
