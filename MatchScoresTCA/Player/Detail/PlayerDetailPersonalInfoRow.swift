//
//  PlayerDetailPersonalInfoRow.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 11.10.2023.
//

import SwiftUI

struct PlayerDetailPersonalInfoRow: View {
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
                Text("Height")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text("\(player.heightFeet ?? 0) ft")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
            
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
                Text("Weight")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text("\(player.weightPounds ?? 0) lbs")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
        }
        .background(Color.blue._300)
    }
}
