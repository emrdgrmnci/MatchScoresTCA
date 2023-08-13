//
//  TeamListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct TeamListView: View {
    let store: StoreOf<TeamListFeature>
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns,
                              spacing: 16) {
                        ForEach(viewStore.searchResults, id: \.id) { team in
                            ForEach(viewStore.gameResults
                                    , id: \.id) { game in
                                NavigationLink {
                                    TeamDetailView(userId: team.id, team: team, gameData: game).id(game.id)
                                } label: {
                                    TeamView(team: team).id(team.id)
                                }
                            }
                        }
                    }
                              .padding()
                              .accessibilityIdentifier("peopleGrid")
                }
                .refreshable {
                    viewStore.send(.onAppearTeamList)
                }
                .searchable(text: viewStore.binding(
                    get: \.searchQuery, send: TeamListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Teams")
            }
            .navigationTitle("Teams")
            .onAppear {
                viewStore.send(.onAppearTeamList)
            }
            .onAppear {
                viewStore.send(.onAppearGameList)
            }
        }
        .embedInNavigation()
    }
}

extension View {
    @ViewBuilder
    func embedInNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}
