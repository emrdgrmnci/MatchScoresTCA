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
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            }
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("peopleGrid")
                }
                .refreshable {
                    viewStore.send(.onAppearPlayer)
                }
                .searchable(text: viewStore.binding(
                    get: \.searchQuery, send: PlayerListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Players")
            }
            .navigationTitle("Players")
            .toolbarBackground(Color.blue._50, for: .navigationBar)
            .toolbarBackground(Color.blue._50, for: .tabBar)
            .onAppear {
                viewStore.send(.onAppearPlayer)
//                viewStore.send(.onAppearStat)
            }
        }
        .background(Color.blue._50)
        .embedInNavigation()
    }
}
