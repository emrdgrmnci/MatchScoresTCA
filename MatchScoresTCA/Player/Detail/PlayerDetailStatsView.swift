//
//  PlayerDetailStatsView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 11.10.2023.
//

import SwiftUI

struct PlayerDetailStatsView: View {
    let player: PlayerData
    @State private var statsData: StatsModel?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue._50
                    .edgesIgnoringSafeArea(.all)
                List {
                    ForEach(statsData?.data ?? []) { data in
                        VStack(spacing: 16) {
                            HStack {
                                Text(dateFormatter(inputDate: data.game?.date ?? ""))
                                Divider()
                                Text(data.team?.fullName ?? "")
                                Divider()
                                Text(data.game?.status?.rawValue ?? "")
                            }
                            
                        }
                        .listRowBackground(Color.blue._50)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Player Stats")
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
