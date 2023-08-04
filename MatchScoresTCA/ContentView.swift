//
//  ContentView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<MatchFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    HStack {
                        if viewStore.isLoadingTeam {
                            Spacer()
                            ProgressView()
                        }
                    }
                    
                    if let fact = viewStore.team {
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()),
                                                     count: 2),
                                      spacing: 16) {
                                ForEach(fact.data, id: \.id) { team in
                                    NavigationLink {
                                        TeamDetailView(userId: team.id - 1)
                                    } label: {
                                        TeamItemView(teams: team)
                                            .accessibilityIdentifier("item_\(team.id)")
                                    }
                                }
                            }
                                      .padding()
                                      .accessibilityIdentifier("peopleGrid")
                        }
                        //              .refreshable {
                        //                  await vm.fetchTeams()
                        //              }
                        //              .searchable(text: "", prompt: "Search NBA Teams")
                        .overlay(alignment: .bottom) {
                            //                  if vm.isFetching {
                            //                      ProgressView()
                            //                  }
                        }
                    }
                }
                .task {
                    viewStore.send(.teamsDataLoaded)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(initialState: MatchFeature.State()) {
                MatchFeature()
                    ._printChanges()
            }
        )
    }
}
