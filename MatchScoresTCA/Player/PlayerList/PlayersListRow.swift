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
                //                    .clipShape(// TODO, fill: // TODO)
                    .frame(
                        width: 100,
                        height: 100
                    )
                
                Text(player.firstName + " " + player.lastName)
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hue: 0, saturation: 0, brightness: 1, opacity: 1))
                
                
            }
        }
//        .position(x: 195, y: 130)
        .background(alignment: .center) {
            RoundedRectangle(
                cornerRadius: 8,
                style: .circular
            )
            .fill(Color(hue: 0.667, saturation: 0.32, brightness: 0.196, opacity: 1))
            
        }
    }
}
