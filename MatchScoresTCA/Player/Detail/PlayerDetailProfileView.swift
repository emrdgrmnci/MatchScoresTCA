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
            Image("figure.basketball")
                .resizable()
                .frame(
                    width: 120,
                    height: 120
                )
                .clipShape(Rectangle()) // Make the image circular
                .aspectRatio(contentMode: .fit) // Maintain aspect rati
            
            Text(player.firstName + " " + player.lastName)
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
            Text(player.position)
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
        }
        .background(Color.blue._300)
    }
}
