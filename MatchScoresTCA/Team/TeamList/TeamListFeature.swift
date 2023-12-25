//
//  TeamListFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

/// Type that represents the state of the
/// This is everything to do its job, including all the state, the view needs, as well as any state that the feature may need to use internally.
struct TeamListFeature: Reducer {
    @Dependency(\.matchScoresClient) var matchScoresClient
    var body: some ReducerOf<TeamListFeature> {
        Reduce { state, action in
            switch action {
                case let .fetchTeamResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting teams, try again later.", level: .debug)
                    return .none // We don't have any action so, no side-effect to run
                    
                case let .fetchTeamResponse(.success(teamData)):
                    state.dataLoadingStatus = .loading
                    state.totalPages =
                    teamData.meta.totalCount
                    state.teamsData = teamData.data
                    state.teamList = IdentifiedArrayOf(
                        uniqueElements: teamData.data.sorted(by: >)
                    )
                    state.isLoading = false
                    return .none // We don't have any action so, no side-effect to run
                    
                case .onAppear:
                    state.isLoading = true
                    state.dataLoadingStatus = .loading
                    return .run { [page = state.page] send in
                        await send (
                            .fetchTeamResponse(
                                TaskResult { try await matchScoresClient.fetchTeams(page) }
                            )
                        )
                    }
                    
                case let .searchQueryChanged(query):
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    state.searchQuery = query
                    
                    if query.isEmpty {
                        state.isLoading = false
                        return .cancel(id: CancelID.team)
                    } else {
                        state.isLoading = false
                    }
//                    guard !query.isEmpty else {
//                        state.isLoading = false
//                        return .cancel(id: CancelID.team)
//                    }
                    
                    return .none // We don't have any action so, no side-effect to run
                    
                case let .fetchTeamNextResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                MatchScoresLogger.log(error, level: .error)
                MatchScoresLogger.log("DEBUG: getting teams next page, try again later.", level: .debug)
                    return .none
                    
                case let .fetchTeamNextResponse(.success(teamData)):
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    state.totalPages = teamData.meta.totalCount
                    state.teamList += IdentifiedArrayOf(uniqueElements: teamData.data.sorted(by: >))
                    state.isLoading = false
                    return .none // We don't have any action so, no side-effect to run
                    
                case .onAppearTeamForNextPage:
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    guard state.page != state.totalPages else { return .none }
                    state.page += 1
                    
                    return .run { [page = state.page] send in
                        await send (
                            .fetchTeamNextResponse(
                                TaskResult { try await MatchScoresClient.liveValue.fetchTeams(page) }
                            )
                        )
                    }
                    
                case .resetData:
                    state.teamsData.removeAll()
                    state.teamList.removeAll()
                    state.page = 1
                    return .none
            }
        }
    }
    
    struct State: Equatable { // What's needed from particular View?
        var dataLoadingStatus = DataLoadingStatus.notStarted // Bool lets us know whether or not data loading started
        var teamList: IdentifiedArrayOf<TeamData> = []
        var searchQuery = "" // Empty for search field
        var page = 1 // Int for pagination
        var totalPages: Int? // We'll have Optional Int TotalPages count
        var teamsData: [TeamData] = []
        var isLoading: Bool = false
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
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
        
        var hasReachedEnd: Bool { // To detect next page for pagination
            return teamsData.contains { teamsData in
                teamsData.id == teamList.last?.id
            }
        }
    }
    
    /// Listing cases for each thing the user can do in the UI such as fetching API data
    /// User started typing into searchfield
    /// Team data shown
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case fetchTeamNextResponse(TaskResult<TeamsModel>)
        case searchQueryChanged(String)
        case onAppear
        case onAppearTeamForNextPage
        case resetData
    }
    
    private enum CancelID { case team }
}
