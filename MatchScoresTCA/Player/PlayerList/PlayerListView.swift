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
            NavigationStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(
                        "Search NBA Players",
                        text: viewStore.binding(
                            get: \.searchQuery, send: PlayerListFeature.Action.searchQueryChanged
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                .padding(.horizontal, 16)
                
                ZStack{
                    ScrollView {
                        LazyVGrid(columns: columns,
                                  spacing: 16) {
                            ForEach(viewStore.searchResults) {
                                //                                NavigationLink {
                                //                                    TeamDetailView(userId: team.id - 1).environmentObject(vm)
                                //                                } label: {
                                //                                    TeamItemView(teams: team)
                                //                                        .accessibilityIdentifier("item_\(team.id)")
                                //                                }
                                PlayerView(player: $0)
                            }
                        }
                                  .padding()
                                  .accessibilityIdentifier("peopleGrid")
                    }
                    .refreshable {
                        viewStore.send(.onAppear)
                    }
                }
                .navigationTitle("Players")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
