//
//  MatchScoresTCAApp.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct MatchScoresTCAApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootFeature.State()) {
                    RootFeature(
                        fetchTeams: {
                            TeamsModel.sample
                        },
                        fetchGames: {
                            GamesModel.sample
                        },
                        fetchPlayers: {
                            PlayersModel.sample
                        },
                        uuid: { UUID() }
                    )
                }
            )
        }
    }
}
