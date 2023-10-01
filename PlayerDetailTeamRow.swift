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
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(player.team.fullName)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
        }
        .background(Color.blue._50)
    }
}
