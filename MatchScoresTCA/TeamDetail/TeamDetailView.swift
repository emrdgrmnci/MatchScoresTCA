//
//  TeamDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

struct TeamDetailView: View {
    
    let team: TeamData
    
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
                    // TODO: - Complete Picker
                    //                    Group {
                    //                        Menu {
                    //                            Picker(selection: $selectedSeason) {
                    //                                ForEach(1949...2023, id:\.self) {
                    //                                    Text("\($0)")
                    //                                        .tag($0)
                    //                                }
                    //                            } label: {}
                    //                        } label: {
                    //                            VStack(alignment: .leading) {
                    //                                Text("Select a season")
                    //                                Divider()
                    //                                Text("Season \(selectedSeason)")
                    //                            }
                    //                        }
                    //                        MatchView(season: selectedSeason, userId: userId)
                    //                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16,
                                                                             style: .continuous))
                    
                }
                       .padding()
            }
        }
        .navigationTitle(team.abbreviation)
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
}
