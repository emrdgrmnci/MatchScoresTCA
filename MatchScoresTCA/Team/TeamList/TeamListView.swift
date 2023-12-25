//
//  TeamListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TeamListView: View {
    let store: Store<TeamListFeature.State, TeamListFeature.Action>
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 16) {
                        ForEach(viewStore.searchResults) { team in
                            NavigationLink {
                                // Check if the index exists in the avatars array
                                if avatars.indices.contains(team.id - 1) {
                                    TeamDetailView(team: team, avatars: avatars[team.id - 1])
                                } else {
                                    TeamDetailView(team: team, avatars: "basketball.circle.fill")
                                }
                            } label: {
                                TeamView(team: team)
                                    .onFirstAppear {
                                        if viewStore.hasReachedEnd {
                                            viewStore.send(.onAppearTeamForNextPage)
                                        }
                                    }
                            }
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("teamsGrid")
                }
                .refreshable {
                    viewStore.send(.resetData) // Reset the data before refreshing
                    viewStore.send(.onAppear) // Then load new data
                }
                .searchable(text: viewStore.binding(
                    get: \.searchQuery, send: TeamListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Teams")
                .overlay {
                    if viewStore.searchResults.isEmpty {
                        ContentUnavailableView.search
                    }
                }
            }
            .navigationTitle("Teams")
            .toolbarBackground(Color.blue._300, for: .navigationBar)
            .toolbarBackground(Color.blue._300, for: .tabBar)
            .onFirstAppear {
                viewStore.send(.onAppear)
            }
        }
        .background(Color.blue._300)
        .embedInNavigation()
    }
}
