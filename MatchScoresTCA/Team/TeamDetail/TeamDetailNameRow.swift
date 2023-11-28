//
//  TeamDetailNameRow.swift
//  MatchScoresTCA
//
//  Created by Emre on 1.10.2023.
//

import SwiftUI

struct TeamDetailNameRow: View {
    let team: TeamData
    
    init(team: TeamData) {
        self.team = team
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Symbols.checkmark
                .frame(
                    width: 64,
                    height: 64
                )
                .mask(alignment: .center) {
                    Circle()
                        .fill(Color(uiColor: .systemGray))
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Team")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
                
                Text(team.fullName)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Color.theme.primaryTextColor)
            }
        }
        .background(Color.blue._300)
    }
}

