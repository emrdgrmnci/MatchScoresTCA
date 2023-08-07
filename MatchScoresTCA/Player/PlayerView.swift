//
//  PlayerView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlayerView: View {
    
    let store: StoreOf<PlayerFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0} ) { viewStore in
            VStack(spacing: .zero) {
                VStack(alignment: .leading) {
                    Text(viewStore.player.firstName)
                        .foregroundColor(Theme.text)
                        .font(
                            .system(.largeTitle, design: .rounded)
                        )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 150.0)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Theme.detailBackground)
                
                VStack {
                    PillView(id: viewStore.player.id)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                }
                
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 16,
                                 style: .continuous)
            )
            .shadow(color: Theme.text.opacity(0.1),
                    radius: 2,
                    x: 0,
                    y: 1)
        }
        .background(Color("launch-screen-background")
            .edgesIgnoringSafeArea([.top, .leading, .trailing]))
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        return PlayerView(
            store: Store(
                initialState: PlayerFeature.State(id: UUID(), player: PlayerData(id: 1, firstName: "Emre", heightFeet: nil, heightInches: nil, lastName: "Degirmenci", position: "G", weightPounds: nil))) {
                    
                }
        )
    }
}