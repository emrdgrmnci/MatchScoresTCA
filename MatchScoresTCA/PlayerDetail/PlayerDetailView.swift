//
//  PlayerDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

struct PlayerDetailView: View {
    let player: PlayerData
    
    init(player: PlayerData) {
        self.player = player
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 16) { // Add spacing between VStacks
                    PlayerDetailProfileView(player: player)
                        .padding(.horizontal, 16) // Add horizontal padding
                    
                    VStack(alignment: .leading, spacing: 16) { // Add spacing between VStacks
                        PlayerDetailNameRow(player: player)
                        Divider()
                        PlayerDetailTeamRow(player: player)
                        Divider()
                        PlayerStatsView(player: player)
                    }
                    .padding(.horizontal, 16) // Add horizontal padding
                }
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle(player.firstName)
            .navigationBarBackButtonHidden(false)
        }
        .background(Color.blue._50)
    }
}

struct PlayerStatsView: View {
    let player: PlayerData
    @State private var statsData: StatsModel?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(statsData?.data ?? []) { data in
                    Text(dateFormatter(inputDate: data.game?.time?.rawValue ?? ""))
                }
            }
            .navigationBarTitle("NBA Stats")
            .navigationTitle("Teams")
            .toolbarBackground(Color.blue._50, for: .navigationBar)
            .toolbarBackground(Color.blue._50, for: .tabBar)
            .task {
                do {
                    self.statsData = try await MatchScoresClient.liveValue.fetchStats(String(player.id))
                } catch(let error) {
                    print(error)
                }
            }
        }
        .background(Color.blue._50)
        .embedInNavigation()
    }
}
