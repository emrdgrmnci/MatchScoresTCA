//
//  MatchFeature.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation
import ComposableArchitecture

// MARK: - Match feature domain

//struct MatchFeature: Reducer {
//    
//    struct State: Equatable {
//        var results: [Datum] = []
//        var resultTeamRequestInFlight: Datum?
//        var isLoading = false
//        var searchQuery = ""
//        var teams: TeamsModel?
//    }
//    enum Action: Equatable {
//        case teamsResponse(TaskResult<TeamsModel>)
//        case teamsDataLoaded
//        case searchQueryChanged(String)
//        case searchQueryChangeDebounced
//        case searchResponse(TaskResult<TeamsModel>)
//        case searchResultTapped(Datum)
//        case onAppear(Datum)
//    }
//    
//    @Dependency(\.matchScoresClient) var matchScoresClient
//    private enum CancelID { case id, team }
//    
//    func reduce(into state: inout State, action: Action) -> Effect<Action> {
//        switch action {
//        case .teamsResponse(.failure):
//            state.teams = nil
//            state.resultTeamRequestInFlight = nil
//            return .none
//            
//        case let .teamsResponse(.success(teams)):
//            state.teams = teams
//            state.resultTeamRequestInFlight = nil
//            return .none
//            
//        case .teamsDataLoaded:
//            state.teams = nil
//            state.isLoading = true
//            return .run { send in
//                //                let (data, _) = try await URLSession.shared
//                //                    .data(from: URL(string: "https://www.balldontlie.io/api/v1/teams")!)
//                //                let team = try JSONDecoder().decode(Teams.self
//                //                                                    , from: data)
//                await send(.teamsResponse(TaskResult {
//                    try await self.matchScoresClient.fetchTeams()
//                }))
//                
//                
//                /*
//                 return .run { [query = state.searchQuery] send in
//                 await send(.searchResponse(TaskResult { try await self.weatherClient.search(query) }))
//                 }
//                 .cancellable(id: CancelID.location)
//                 */
//            }
//            
//        case let .searchQueryChanged(query):
//            state.searchQuery = query
//            
//            // When the query is cleared we can clear the search results, but we have to make sure to cancel
//            // any in-flight search requests too, otherwise we may get data coming in later.
//            guard !query.isEmpty else {
//                state.results = []
//                state.teams = nil
//                return .cancel(id: CancelID.id)
//            }
//            return .none
//            
//        case .searchQueryChangeDebounced:
//            guard !state.searchQuery.isEmpty else {
//                return .none
//            }
//            return .run { [query = state.searchQuery] send in
//                await send(.searchResponse(TaskResult { try await self.matchScoresClient.search(query) }))
//            }
//            .cancellable(id: CancelID.id)
//            
//        case .searchResponse(.failure):
//            state.results = []
//            return .none
//            
//        case let .searchResponse(.success(response)):
//            state.results = response.data
//            return .none
//            
//        case let .searchResultTapped(datum):
//            state.resultTeamRequestInFlight = datum
//            return .run { send in
//                    await send(
//                      .teamsResponse(
//                        TaskResult { try await self.matchScoresClient.fetchTeams() }
//                      )
//                    )
//                  }
//            .cancellable(id: CancelID.team, cancelInFlight: true)
//            
//        case let .onAppear(teams):
//            state.resultTeamRequestInFlight = teams
//            return .run { send in
//                await send(.teamsResponse(TaskResult { try await self.matchScoresClient.fetchTeams() }))
//            }
//            .cancellable(id: CancelID.id)
////                .run { [query = state.searchQuery] send in
////                await send(.searchResponse(TaskResult { try await self.matchScoresClient.search(query) }))
////            }
////            .cancellable(id: CancelID.id)
//        }
//    }
//}
