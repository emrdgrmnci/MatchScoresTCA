//
//  PlayersListRow.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 30.09.2023.
//

import SwiftUI

struct PlayersListRow: View {
    
    let player: PlayerData
    
    init(player: PlayerData) {
        self.player = player
    }
    
    var body: some View {
        VStack {
            VStack {
                Image("figure.basketball")
                    .resizable()
                    .frame(
                        width: 80,
                        height: 80
                    )
                
                Text(player.firstName + " " + player.lastName)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                Text(player.position)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                Text(player.team.fullName)
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 180.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .green, .red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(color: Theme.text.opacity(0.1),
                    radius: 2,
                    x: 0,
                    y: 1)
            .edgesIgnoringSafeArea([.top, .leading, .trailing])
        }
    }
}
