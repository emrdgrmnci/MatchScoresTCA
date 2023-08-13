//
//  TeamDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TeamDetailView: View {
    
    let userId: Int
    let team: TeamData
    let gameData: GameData
    
    let seasonId = 0
    let user = 0
    
    let columns = Array(repeating: GridItem(.flexible()),
                        count: 3)
    
    @State var selectedSeason = 1949
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 18) {
                    Group {
                        general
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                             style: .continuous))
                }
                       .padding()
            }
        }
        .navigationTitle(team.abbreviation)
        
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading,
                       spacing: 18) {
                    Group {
                        game
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                             style: .continuous))
                }
                       .padding()
            }
        }
    }
}

private extension TeamDetailView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}

private extension TeamDetailView {
    
    var general: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            PillView(id: team.id + 1)
            
            Group {
                name
                fullName
                city
            }
            .foregroundColor(Theme.text)
        }
    }
    
    @ViewBuilder
    var name: some View {
        Text("Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.heavy)
            )
        
        Text(team.name)
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var fullName: some View {
        Text("Full Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.heavy)
            )
        
        Text(team.fullName)
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var city: some View {
        Text("City")
            .font(
                .system(.body, design: .rounded)
                .weight(.heavy)
            )
        
        Text(team.city)
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
    @ViewBuilder
    var game: some View {
        ScrollView {
            LazyVGrid(columns: columns,
                      spacing: 16) {
                Group {
                    Text("Home")
                        .font(
                            .system(.callout, design: .rounded)
                            .weight(.heavy)
                        )
                    
                    
                    Text("Score")
                        .font(
                            .system(.callout, design: .rounded)
                            .weight(.heavy)
                        )
                    Text("Away")
                        .font(
                            .system(.callout, design: .rounded)
                            .weight(.heavy)
                        )
                }
                
                Text(gameData.homeTeam.abbreviation)
                    .font(
                        .system(.subheadline, design: .rounded)
                    )
                
                Text("\(gameData.homeTeamScore) - \(gameData.visitorTeamScore)")
                    .font(
                        .system(.subheadline, design: .rounded)
                    )
                
                Text(gameData.visitorTeam.abbreviation)
                    .font(
                        .system(.subheadline, design: .rounded)
                    )
            }
                      .padding()
                      .accessibilityIdentifier("peopleGrid")
        }
    }
}
