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
                        PlayerDetailTeamRow(player: player)
                        Divider()
                        PlayerDetailPersonalInfoRow(player: player)
                        Divider()
                        PlayerDetailStatsView(player: player)
                            .padding(.bottom, 8)
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
