//
//  PlayerListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct PlayerListView: View {
    let store: StoreOf<PlayerListFeature>
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 16) {
                    ForEachStore(
                        self.store.scope(
                            state: \.playerList,
                            action: PlayerListFeature.Action
                                .player(id: action:)
                        )
                    ) {
                        PlayerView(store: $0)
                    }
                }
                          .padding()
                          .accessibilityIdentifier("peopleGrid")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
