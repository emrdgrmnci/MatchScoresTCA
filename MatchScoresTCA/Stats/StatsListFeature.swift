//
//  StatsListFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 5.10.2023.
//

import ComposableArchitecture
import SwiftUI

struct StatsListFeature: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var statsList: IdentifiedArrayOf<StatsData> = []
        var searchQuery = ""
        var stats = [StatsData]()
        
        var shouldShowErr: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<StatsData> {
            guard !searchQuery.isEmpty else {
                return statsList
            }
            return statsList.filter {
                $0.team.fullName.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    enum Action: Equatable {
        case fetchStatResponse(TaskResult<StatsModel>)
        case searchQueryChanged(String)
        case onAppear
    }
    
    var uuid: @Sendable () -> UUID
    private enum CancelID { case stats }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .fetchStatResponse(.failure(error)):
            state.dataLoadingStatus = .error
            print(error)
            print("DEBUG: Error getting stats, try again later.")
            return .none
            
        case let .fetchStatResponse(.success(statData)):
            state.statsList = IdentifiedArrayOf(uniqueElements: statData.data)
            state.stats = statData.data
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppear:
            return .run { send in
                await send (
                    .fetchStatResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchStats()
                        }
                    )
                )
            }
            
        case let .searchQueryChanged(query):
            state.searchQuery = query
            guard !query.isEmpty else {
                return .cancel(id: CancelID.stats)
            }
            return .none
        }
    }
}
