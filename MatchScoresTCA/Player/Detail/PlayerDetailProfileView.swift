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
            
            Text(player.firstName + " " + player.lastName)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
            Text(player.position)
        }
    }
}
