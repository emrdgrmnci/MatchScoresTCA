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
        var statsList: IdentifiedArrayOf<StatsData> = []
        var searchQuery = ""
        var page = 1
        var totalPages: Int?
        var playersData: [PlayerData] = []
        
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
            
            let filteredAndSortedArray = playerList
                .sorted(by: { $0.firstName.lowercased() > $1.firstName.lowercased() })
                .filter { "\($0.firstName)\($0.lastName)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.position)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.team.fullName)".lowercased().contains(searchQuery.lowercased()) ||
                    "\($0.team.city)".lowercased().contains(searchQuery.lowercased())
                }
            return .init(uniqueElements: filteredAndSortedArray)
        }
        
        var hasReachedEnd: Bool {
            return playersData.contains { playerData in
                playerData.id == playerList.last?.id
            }
        }
    }
    
    enum Action: Equatable {
        case fetchPlayerResponse(TaskResult<PlayersModel>)
        case fetchPlayerNextResponse(TaskResult<PlayersModel>)
        case fetchStatsResponse(TaskResult<StatsModel>)
        case searchQueryChanged(String)
        case onAppearPlayer
        case onAppearPlayerForNextPage
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
                state.totalPages = playerData.meta.totalCount
                state.playersData = playerData.data
                state.playerList = IdentifiedArrayOf(
                    uniqueElements: playerData.data.sorted(by: >)
                )
                state.dataLoadingStatus = .loading
                return .none
                
            case let .fetchPlayerNextResponse(.failure(error)):
                state.dataLoadingStatus = .error
                print(error)
                print("DEBUG: getting players, try again later.")
                return .none
                
            case let .fetchPlayerNextResponse(.success(playerData)):
                state.totalPages = playerData.meta.totalCount
                state.playerList += IdentifiedArrayOf(
                    uniqueElements: playerData.data.sorted(by: >)
                )
                state.dataLoadingStatus = .loading
                return .none
                
            case .onAppearPlayer:
                return .run { [page = state.page] send in
                    await send (
                        .fetchPlayerResponse(
                            TaskResult { try await MatchScoresClient.liveValue.fetchPlayers(page) }
                        )
                    )
                }
                
            case let .searchQueryChanged(query):
                state.searchQuery = query
                guard !query.isEmpty else {
                    return .cancel(id: CancelID.player)
                }
                return .none
                
            case .fetchStatsResponse(.failure(let error)):
                state.dataLoadingStatus = .error
                print(error)
                print("DEBUG: getting stats, try again later.")
                return .none
                
            case let .fetchStatsResponse(.success(statsData)):
                state.statsList = IdentifiedArrayOf(
                    uniqueElements: statsData.data
                )
                state.dataLoadingStatus = .loading
                return .none
                
            case .onAppearPlayerForNextPage:
                guard state.page != state.totalPages else { return .none }
                state.page += 1
                
                return .run { [page = state.page] send in
                    await send (
                        .fetchPlayerNextResponse(
                            TaskResult { try await MatchScoresClient.liveValue.fetchPlayers(page) }
                        )
                    )
                }
        }
    }
}
