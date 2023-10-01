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
        HStack(spacing: 80) {
            VStack(spacing: 6) {
                Image("allen")
                    .frame(
                        width: 100,
                        height: 100
                    )
                    .clipShape(Circle()) // Make the image circular
                    .aspectRatio(contentMode: .fit) // Maintain aspect ratio
                
                Text(player.firstName + " " + player.lastName)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
        }
    }
}
