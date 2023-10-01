//
//  PlayerView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlayerView: View {
    
    let player: PlayerData
    
    var body: some View {
        VStack(spacing: .zero) {
            
//            background
            
            VStack(alignment: .leading) {
                Text("\(player.firstName) \(player.lastName)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.largeTitle, design: .rounded)
                    )
//                    .background(
//                        Image(avatars[player.id - 1])
//                            .opacity(0.4)
//                            .aspectRatio(contentMode: .fill)
//                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 150.0)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            
            VStack {
                PillView(id: player.id)
                    .padding(.leading, 10)
                    .padding(.top, 10)
            }
        }
        .toolbarBackground(Color.blue._50, for: .navigationBar)
        .toolbarBackground(Color.blue._50, for: .tabBar)
        .clipShape(
            RoundedRectangle(cornerRadius: 16,
                             style: .continuous)
        )
        .shadow(color: Theme.text.opacity(0.1),
                radius: 2,
                x: 0,
                y: 1)
        .edgesIgnoringSafeArea([.top, .leading, .trailing])
    }
}

private extension PlayerView {
    
//    var background: some View {
//        Theme.background
//            .ignoresSafeArea(edges: .top)
//    }
    
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

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        return PlayerView(player: PlayerData(id: 14, firstName: "Ike", heightFeet: nil, heightInches: nil, lastName: "Anigbogu", position: "C", team: TeamData(id: 12, abbreviation: "IND", city: "Indiana", conference: "East", division: "Central", fullName: "Indiana Pacers", name: "Pacers"), weightPounds: nil))
    }
}
