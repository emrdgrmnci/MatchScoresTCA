//
//  PlayerDetailProfileView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 30.09.2023.
//

import SwiftUI

struct PlayerDetailProfileView: View {
    let player: PlayerData
    
    init(player: PlayerData) {
        self.player = player
    }
    
    var body: some View {
        VStack() {
            Image("allen")
            //                                                    .clipShape(// TODO, fill: // TODO)
                .frame(
                    width: 100,
                    height: 100
                )
                .clipShape(Circle()) // Make the image circular
                .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            
            Text(player.firstName + " " + player.lastName)
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
            Text(player.position)
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
        }
    }
}
