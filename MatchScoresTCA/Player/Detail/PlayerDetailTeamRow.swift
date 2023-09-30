//
//  PlayerDetailTeamRow.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 30.09.2023.
//

import SwiftUI

struct PlayerDetailTeamRow: View {
    let player: PlayerData
    
    init(player: PlayerData) {
        self.player = player
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Symbols.person
                .frame(
                    width: 64,
                    height: 64
                )
                .mask(alignment: .center) {
                    Circle()
                        .fill(Color(uiColor: .systemGray))
                }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Team")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(Color(uiColor: .white))
                
                Text(player.team.fullName)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.769, opacity: 1))
            }
        }
        .padding(16)
        .background(alignment: .center) {
            RoundedRectangle(
                cornerRadius: 8,
                style: .circular
            )
            .fill(Color(hue: 0.667, saturation: 0.32, brightness: 0.196, opacity: 1))
        }
    }
}
