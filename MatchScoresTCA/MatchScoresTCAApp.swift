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
            ContentView(
                store: Store(initialState: MatchFeature.State()) {
                    MatchFeature()
                }
            )
        }
    }
}
