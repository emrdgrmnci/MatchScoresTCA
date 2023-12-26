//
//  GameListFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct GameListFeature: Reducer {
    @Dependency(\.matchScoresClient) var matchScoresClient
    var body: some ReducerOf<GameListFeature> {
        Reduce { state, action in
            switch action {
                case let .fetchGameResponse(.failure(error)):
                    state.dataLoadingStatus = .error
                    state.isLoading = false
                    MatchScoresLogger.log(error, level: .error)
                    MatchScoresLogger.log("DEBUG: getting games, try again later.", level: .debug)
                    return .none
                    
                case let .fetchGameResponse(.success(gameData)):
                    state.dataLoadingStatus = .loading
                    state.totalPages = gameData.meta.totalCount
                    state.gamesData = gameData.data
                    state.gameList = IdentifiedArrayOf(uniqueElements: gameData.data)
                    state.isLoading = false
                    return .none
                    
                case .onAppear:
                    state.isLoading = true
                    state.dataLoadingStatus = .loading
                    return .run { send in
                        await send (
                            .fetchGameResponse(
                                TaskResult { try await matchScoresClient.fetchGames()
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
                        return .cancel(id: CancelID.game)
                    }
                    return .none
                    
                case let .searchTokenChanged(tokens):
                    state.dataLoadingStatus = .loading
                    state.isLoading = true
                    state.tokens = tokens
                    
                    guard !tokens.isEmpty else {
                        state.isLoading = false
                        return .cancel(id: CancelID.game)
                    }
                    return .none
            }
        }
    }
    
    struct State: Equatable {
        var dataLoadingStatus = DataLoadingStatus.notStarted
        var gameList: IdentifiedArrayOf<GameData> = []
        var searchQuery = ""
        var totalPages: Int?
        var gamesData: [GameData] = []
        var tokens: [GameInfoToken] = []
        var isLoading: Bool = false
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var searchResults: IdentifiedArrayOf<GameData> {
            guard !searchQuery.isEmpty else {
                return gameList
            }
            let filteredAndSortedArray = gameList.filter { $0.homeTeam.fullName.lowercased().contains(searchQuery.lowercased()) || $0.visitorTeam.fullName.lowercased().contains(searchQuery.lowercased()) ||
                $0.date.lowercased().contains(searchQuery.lowercased())
            }
            return .init(uniqueElements: filteredAndSortedArray)
        }
    }
    
    enum Action: Equatable {
        case fetchGameResponse(TaskResult<GamesModel>)
        case searchQueryChanged(String)
        case searchTokenChanged([GameInfoToken])
        case onAppear
    }
    
    private enum CancelID { case game }
}
