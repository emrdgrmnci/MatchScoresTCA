//
//  PlayerFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import ComposableArchitecture
import SwiftUI

/// Type that represents the state of the
/// This is everything to do its job, including all the state, the view needs, as well as any state that the feature may need to use internally.
struct PlayerListFeature: Reducer {
    @Dependency(\.matchScoresClient) var matchScoresClient
    var body: some ReducerOf<PlayerListFeature> {
        Reduce { state, action in
            switch action {
                case let .fetchPlayerResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting players, try again later.", level: .debug)
                    return .none
                    
                case let .fetchPlayerResponse(.success(playerData)):
                    state.dataLoadingStatus = .loading
                    state.totalPages = playerData.meta.totalCount
                    state.playersData = playerData.data
                    state.playerList = IdentifiedArrayOf(
                        uniqueElements: playerData.data.sorted(by: >)
                    )
                    state.isLoading = false
                    return .none // We don't have any action so, no side-effect to run
                    
                case let .fetchPlayerNextResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting players, try again later.", level: .debug)
                    return .none
                    
                case let .fetchPlayerNextResponse(.success(playerData)):
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    state.totalPages = playerData.meta.totalCount
                    state.playersData = playerData.data
                    state.playerList += IdentifiedArrayOf(
                        uniqueElements: playerData.data.sorted(by: >)
                    )
                    state.isLoading = false
                    return .none
                    
                case .onAppear:
                    state.isLoading = true
                    state.dataLoadingStatus = .loading
                    return .run { [page = state.page] send in
                        await send (
                            .fetchPlayerResponse(
                                TaskResult { 
                                    try await matchScoresClient.fetchPlayers(page)
                                }
                            )
                        )
                    }
                case let .searchQueryChanged(query):
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    state.searchQuery = query
                    guard !query.isEmpty else {
                        state.isLoading = false
                        return .cancel(id: CancelID.player)
                    }
                    return .none
                    
                case let .fetchStatsResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting stats, try again later.", level: .debug)
                    return .none
                    
                case let .fetchStatsResponse(.success(statsData)):
                    state.dataLoadingStatus = .loading
                    state.isLoading = false
                    state.statsList = IdentifiedArrayOf(
                        uniqueElements: statsData.data
                    )
                    return .none
                    
                case .onAppearPlayerForNextPage:
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    guard state.page != state.totalPages else { return .none }
                    state.page += 1
                    
                    return .run { [page = state.page] send in
                        await send (
                            .fetchPlayerNextResponse(
                                TaskResult { try await MatchScoresClient.liveValue.fetchPlayers(page) }
                            )
                        )
                    }
                    
                case .resetData:
                    state.playersData.removeAll()
                    state.playerList.removeAll()
                    return .none
            }
        }
    }
    
    struct State: Equatable { // What's needed from particular View?
        var dataLoadingStatus = DataLoadingStatus.notStarted // Bool lets us know whether or not data loading started
        var playerList: IdentifiedArrayOf<PlayerData> = []
        var statsList: IdentifiedArrayOf<StatsData> = []
        var searchQuery = "" // Empty for search field
        var page = 1 // Int for pagination
        var totalPages: Int? // We'll have Optional Int TotalPages count
        var playersData: [PlayerData] = []
        var isLoading: Bool = false
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var searchResults: IdentifiedArrayOf<PlayerData> {
            guard !searchQuery.isEmpty else {
                return playerList
            }
            
            let filteredAndSortedArray = playerList
                .sorted(by: { $0.firstName.lowercased() > $1.firstName.lowercased() })
                .filter { "\($0.firstName) \($0.lastName)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.position)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.team.fullName)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.team.city)".lowercased().contains(searchQuery.lowercased())
                }
            return .init(uniqueElements: filteredAndSortedArray)
        }
        
        var hasReachedEnd: Bool { // To detect next page for pagination
            return playersData.contains { playerData in
                playerData.id == playerList.last?.id
            }
        }
    }
    
    /// Listing cases for each thing the user can do in the UI such as fetching API data
    /// User started typing into searchfield
    /// Player and related Stats data shown
    enum Action: Equatable {
        case fetchPlayerResponse(TaskResult<PlayersModel>)
        case fetchPlayerNextResponse(TaskResult<PlayersModel>)
        case fetchStatsResponse(TaskResult<StatsModel>)
        case searchQueryChanged(String)
        case onAppear
        case onAppearPlayerForNextPage
        case resetData
    }
    
    private enum CancelID { case player }
}
