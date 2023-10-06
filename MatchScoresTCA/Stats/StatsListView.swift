//
//  StatsListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 5.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct StatsListView: View {
    let store: StoreOf<StatsListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.state.stats.indices, id: \.self) { index in
                        Text("\(viewStore.state.stats[index].player.firstName) \(viewStore.state.stats[index].player.lastName): \(viewStore.state.stats[index].pts) points")
                    }
                    .refreshable {
                        viewStore.send(.onAppear)
                    }
                    .searchable(text: viewStore.binding(
                        get: \.searchQuery, send: StatsListFeature.Action.searchQueryChanged
                    ), placement: .automatic, prompt: "Search NBA Stats")
                }
                .navigationBarTitle("NBA Stats")
                .navigationTitle("Teams")
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
            .background(Color.blue._50)
            .embedInNavigation()
        }
    }
}

//#Preview {
//    StatsListView()
//}
