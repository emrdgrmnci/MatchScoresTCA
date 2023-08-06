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
            TeamView(
                store: Store(initialState: MatchFeature.State()) {
                    MatchFeature()
                }
            )
        }
    }
}

/*
 var filteredTeams: [Datum] {
     guard !searchTerm.isEmpty else { return teams }
     return teams.filter { $0.fullName.description.localizedCaseInsensitiveContains(searchTerm) }
 }
 */
