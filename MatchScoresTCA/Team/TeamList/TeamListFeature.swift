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
        var results: [TeamData] = []
        var resultTeamRequestInFlight: TeamsModel?
        var teamList: IdentifiedArrayOf<TeamFeature.State> = []
        
        var shouldShowError: Bool {
            dataLoadingStatus == .error
        }
        
        var isLoading: Bool {
            dataLoadingStatus == .loading
        }
        
    }
    
    enum Action: Equatable {
        case fetchTeamResponse(TaskResult<TeamsModel>)
        case team(id: TeamFeature.State.ID, action: TeamFeature.Action)
        case onAppear
        
    }
    
    var uuid: @Sendable () -> UUID
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        case .fetchTeamResponse(.failure(let error)):
            state.dataLoadingStatus = .error
            print(error)
            print("Error getting products, try again later.")
            return .none
            
        case let .fetchTeamResponse(.success(teamData)):
            state.teamList = IdentifiedArrayOf(
                uniqueElements: teamData.data.map {
                    TeamFeature.State(
                        id: uuid(),
                        team: $0
                    )
                }
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
        case .team:
            return .none
        }
    }
}

/*
 Reducer/Feature that contains the state and handles actions for 3 separate screens (Teams, Players, Favorites). These would be the next logical steps:
 Create an explicit Action and State  for each screen
 */
