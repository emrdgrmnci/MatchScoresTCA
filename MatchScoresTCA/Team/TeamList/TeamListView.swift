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
            NavigationStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField(
                        "Search NBA Teams",
                        text: viewStore.binding(
                            get: \.searchQuery, send: TeamListFeature.Action.searchQueryChanged
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
                                TeamView(team: $0)
                            }
                        }
                                  .padding()
                                  .accessibilityIdentifier("peopleGrid")
                    }
                    .refreshable {
                        viewStore.send(.onAppear)
                    }
                }
                .navigationTitle("Teams")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
