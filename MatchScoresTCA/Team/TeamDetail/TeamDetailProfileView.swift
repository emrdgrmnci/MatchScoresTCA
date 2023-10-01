//
//  TeamDetailProfileView.swift
//  MatchScoresTCA
//
//  Created by Emre on 1.10.2023.
//

import SwiftUI

struct TeamDetailProfileView: View {
    let team: TeamData
    let image: String
    
    init(team: TeamData, image: String) {
        self.team = team
        self.image = image
    }
    
    var body: some View {
        VStack() {
            Image(image)
                .resizable()
                .frame(
                    width: 100,
                    height: 100
                )
                .clipShape(Circle()) // Make the image circular
                .aspectRatio(contentMode: .fit) // Maintain aspect ratio
            
            Text(team.fullName)
                .font(.system(.title, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
            
            Text(team.division)
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color.theme.primaryTextColor)
        }
        .background(Color.blue._50)
    }
}
