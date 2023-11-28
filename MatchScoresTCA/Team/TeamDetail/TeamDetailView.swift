//
//  TeamDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    let team: TeamData
    var avatars = ""
    
    init(team: TeamData, avatars: String) {
        self.team = team
        self.avatars = avatars
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 24) { // Add spacing between VStacks
                    TeamDetailProfileView(team: team, image: avatars)
                        .padding(.horizontal, 16) // Add horizontal padding
                    
                    VStack(alignment: .leading, spacing: 16) { // Add spacing between VStacks
                        TeamDetailNameRow(team: team)
                        Divider()
                        TeamDetailConferenceRow(team: team)
                        Divider()
                        TeamDetailFoundationRow(team: team)
                        Divider()
                        TeamDetailDivisionRow(team: team)
                    }
                    .padding(.horizontal, 16) // Add horizontal padding
                }
                .toolbarBackground(Color.blue._300, for: .navigationBar)
                .toolbarBackground(Color.blue._300, for: .tabBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle(team.abbreviation)
            .navigationBarBackButtonHidden(false)
        }
        .background(Color.blue._300)
    }
}
