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
        var page = 1
        var totalPages: Int?
        var teamsData: [TeamData] = []
        
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
            
            let filteredAndSortedArray = teamList
                .sorted(by: { $0.fullName.lowercased() > $1.fullName.lowercased() })
                .filter { $0.fullName.lowercased().contains(searchQuery.lowercased()) }
            
            return .init(uniqueElements: filteredAndSortedArray)
        }
        
        var hasReachedEnd: Bool {
            return teamsData.contains { teamsData in
                teamsData.id == teamList.last?.id
            }
        }
    }
    
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case fetchTeamNextResponse(TaskResult<TeamsModel>)
        case searchQueryChanged(String)
        case onAppear
        case onAppearTeamForNextPage
    }
    
    var uuid: @Sendable () -> UUID
    private enum CancelID { case team }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            case let .fetchTeamResponse(.failure(error)):
                state.dataLoadingStatus = .error
                print(error)
                print("DEBUG: getting teams, try again later.")
                return .none
                
            case let .fetchTeamResponse(.success(teamData)):
                state.totalPages =
                teamData.meta.totalCount
                state.teamsData = teamData.data
                state.teamList = IdentifiedArrayOf(
                    uniqueElements: teamData.data.sorted(by: >)
                )
                state.dataLoadingStatus = .loading
                return .none
                
            case .onAppear:
                return .run { [page = state.page] send in
                    await send (
                        .fetchTeamResponse(
                            TaskResult { try await MatchScoresClient.liveValue.fetchTeams(page)
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
                
            case let .fetchTeamNextResponse(.failure(error)):
                state.dataLoadingStatus = .error
                print(error)
                print("DEBUG: getting teams next page, try again later.")
                return .none
                
            case let .fetchTeamNextResponse(.success(teamData)):
                state.totalPages = teamData.meta.totalCount
                state.teamList += IdentifiedArrayOf(uniqueElements: teamData.data.sorted(by: >))
                state.dataLoadingStatus = .loading
                return .none
                
            case .onAppearTeamForNextPage:
                guard state.page != state.totalPages else { return .none }
                state.page += 1
                
                return .run { [page = state.page] send in
                    await send (
                        .fetchTeamNextResponse(
                            TaskResult { try await MatchScoresClient.liveValue.fetchTeams(page) }
                        )
                    )
                }
        }
    }
}
