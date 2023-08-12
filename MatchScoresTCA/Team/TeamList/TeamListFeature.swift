//
//  TeamListFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct TeamListFeature: Reducer {
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var teamList: IdentifiedArrayOf<TeamData> = []
        var searchQuery = ""
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<TeamData> {
            guard !searchQuery.isEmpty else {
                return teamList
            }
            return teamList.filter { $0.fullName.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case searchQueryChanged(String)
        //        case searchResultTapped(IdentifiedArrayOf<TeamData>)
        case onAppear
    }
    
    var uuid: @Sendable () -> UUID
    
    private enum CancelID { case team }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchTeamResponse(.failure(let error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting players, try again later.")
            return .none
            
        case let .fetchTeamResponse(.success(teamData)):
            state.teamList = IdentifiedArrayOf(
                uniqueElements: teamData.data
            )
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppear:
            return .run { send in
                await send (
                    .fetchTeamResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchTeams()
                        }
                    )
                )
            }
            
        case let .searchQueryChanged(query):
            state.searchQuery = query
            guard !query.isEmpty else {
                return .cancel(id: CancelID.team)
            }
            return .none
        }
    }
}
