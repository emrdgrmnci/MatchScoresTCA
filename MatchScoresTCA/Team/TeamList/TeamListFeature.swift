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
        var gameList: IdentifiedArrayOf<GameData> = []
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
        
        var gameResults: IdentifiedArrayOf<GameData> {
            return gameList
        }
    }
    
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case fetchGameResponse(TaskResult<GamesModel>)
        case searchQueryChanged(String)
        case onAppearTeamList
        case onAppearGameList
    }
    
    var uuid: @Sendable () -> UUID
    private enum CancelID { case team }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .fetchTeamResponse(.failure(error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting teams, try again later.")
            return .none
            
        case let .fetchTeamResponse(.success(teamData)):
            state.teamList = IdentifiedArrayOf(
                uniqueElements: teamData.data
            )
            state.dataLoadingStatus = .loading
            return .none
            
        case .onAppearTeamList:
            return .run { send in
                await send (
                    .fetchTeamResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchTeams()
                        }
                    )
                )
            }
            
        case .onAppearGameList:
            return .run { send in
                await send (
                    .fetchGameResponse(
                        TaskResult { try await MatchScoresClient.liveValue.fetchGames()
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
            
        case let .fetchGameResponse(.failure(error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting games, try again later.")
            return .none
            
        case let .fetchGameResponse(.success(gameData)):
            state.gameList = IdentifiedArrayOf(
                uniqueElements: gameData.data
            )
            state.dataLoadingStatus = .loading
            return .none
        }
    }
}
