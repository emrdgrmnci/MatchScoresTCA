//
//  PlayerDetailView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

struct PlayerDetailView: View {
    
    let player: PlayerData
    
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
        .navigationTitle(player.firstName)
    }
}

private extension PlayerDetailView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}

private extension PlayerDetailView {
    
    var general: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            PillView(id: player.id + 1)
            
            Group {
                fullName
                team
                city
            }
            .foregroundColor(Theme.text)
        }
    }
    
    @ViewBuilder
    var fullName: some View {
        Text("Full Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.heavy)
            )
        
        Text(player.firstName + player.lastName)
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var team: some View {
        Text("Team")
            .font(
                .system(.body, design: .rounded)
                .weight(.heavy)
            )
        
        Text(player.team.fullName)
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
        
        Text(player.team.city)
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}


struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: PlayerData(id: 14, firstName: "Kobe", heightFeet: nil, heightInches: nil, lastName: "Bryant", position: "G", team: TeamData(id: 12, abbreviation: "LAK", city: "Los Angeles", division: "East", fullName: "Kobe Bryant", name: "Kobe"), weightPounds: nil))
    }
}
