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
                    print(error)
                    print("DEBUG: Error getting games, try again later.")
                    return .none
                    
                case let .fetchGameResponse(.success(gameData)):
                    state.totalPages = gameData.meta.totalCount
                    state.gamesData = gameData.data
                    state.gameList = IdentifiedArrayOf(uniqueElements: gameData.data)
                    state.dataLoadingStatus = .loading
                    return .none
                    
                case .onAppear:
                    state.dataLoadingStatus = .loading
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
                        return .cancel(id: CancelID.game)
                    }
                    return .none
                    
                case let .searchTokenChanged(tokens):
                    state.tokens = tokens
                    guard !tokens.isEmpty else {
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
        var gamesData = [GameData]()
        var tokens: [GameInfoToken] = []
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
        var searchResults: IdentifiedArrayOf<GameData> {
            guard !searchQuery.isEmpty else {
                return gameList
            }
            return gameList.filter { $0.homeTeam.fullName.lowercased().contains(searchQuery.lowercased()) || $0.visitorTeam.fullName.lowercased().contains(searchQuery.lowercased()) ||
                $0.date.lowercased().contains(searchQuery.lowercased())
            }
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
