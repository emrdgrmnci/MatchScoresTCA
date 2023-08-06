//
//  TeamView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import ComposableArchitecture
import SwiftUI

struct TeamView: View {
    let store: StoreOf<MatchFeature>
    
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            NavigationStack {
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField(
                            "Search for NBA Teams",
                            text: viewStore.binding(
                                get: \.searchQuery, send: MatchFeature.Action.teamsDataLoaded
                            )
                        )
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    .padding(.horizontal, 16)
                    
                    ScrollView {
                        LazyVGrid(columns: columns,
                                  spacing: 16) {
                            ForEach(viewStore.results) { location in
                                VStack(alignment: .leading) {
                                    Text(location.fullName)

                                }
                            }
                        }
                    }
                    }
                .onAppear { viewStore.send(.onAppear()) }
//                .task(id: viewStore.teams) {
//                        do {
//                            await viewStore.send(.teamsDataLoaded).finish()
//                        } catch {}
//                }
//                .navigationTitle("Search")
//            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(
            store: Store(initialState: MatchFeature.State()) {
                MatchFeature()
                    ._printChanges()
            }
        )
    }
}
