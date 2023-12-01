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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootFeature.State()) {
                    RootFeature(
                        fetchTeams: { _ in
                            TeamsModel.sample
                        },
                        fetchGames: {
                            GamesModel.sample
                        },
                        fetchPlayers: { _ in 
                            PlayersModel.sample
                        },
                        uuid: { UUID() }
                    )
                    ._printChanges()
                }
            )
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        print("🧑🏼‍🚀 is UI Test Running: \(UITestingHelper.isUITesting)")
        #endif
        return true
    }
}
