//
//  TeamView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TeamView: View {
        
    let team: TeamData
    
    init(team: TeamData) {
        self.team = team
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack(alignment: .center, spacing: 10) {
                // Check if the index exists in the avatars array
                if avatars.indices.contains(team.id - 1) {
                    // If it exists, use the corresponding avatar
                    Image(avatars[team.id - 1])
                        .resizable()
                        .frame(width: 80, height: 80)
                } else {
                    // If it doesn't exist, display ContentUnavailableView
                    Image("basketball.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                Text(team.fullName)
                    .font(
                        .system(.headline, design: .rounded)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .leading)
            .frame(height: 150.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .green, .red]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: 1
                )
        )
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
    }
}

private extension TeamView {
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    var refresh: some View {
        Button {
            Task {
                // await vm.fetchTeams()
            }
        } label: {
            Symbols.refresh
        }
        // .disabled(vm.isLoading)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: .init(id: 1, abbreviation: "ATL", city: "Atlanta", conference: "East", division: "Southeast", fullName: "Atlanta Hawks", name: "Hawks"))
    }
}
