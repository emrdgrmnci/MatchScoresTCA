//
//  TeamListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import SwiftUI
import Combine
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
                        ForEach(viewStore.searchResults) { team in
                            NavigationLink {
                                TeamDetailView(team: team)
                            } label: {
                                TeamView(team: team)
                                    .accessibilityIdentifier("item_\(team.id)")
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
                    get: \.searchQuery, send: TeamListFeature.Action.searchQueryChanged
                ), placement: .automatic, prompt: "Search NBA Teams")
            }
            .navigationTitle("Teams")
            .onAppear {
                viewStore.send(.onAppear)
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
