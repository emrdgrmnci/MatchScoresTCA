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
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 16) {
                        ForEach(viewStore.searchResults) { player in
                            NavigationLink {
                                PlayerDetailView(player: player)
                            } label: {
                                PlayersListRow(player: player)
                            }
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("peopleGrid")
                }
                .refreshable {
                    viewStore.send(.onAppear)
                }
                .searchable(text: viewStore.binding(
                    get: \.searchQuery, send: PlayerListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Players")
            }
            .navigationTitle("Players")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        .background(Color.blue._50)
        .embedInNavigation()
    }
}
