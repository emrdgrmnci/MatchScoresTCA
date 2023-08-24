//
//  GameListView.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI
import ComposableArchitecture

struct GameListView: View {
    let store: StoreOf<GameListFeature>
    let columns = Array(repeating: GridItem(.flexible()),
                        count: 3)
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) {
            viewStore in
            ScrollView {
                LazyVGrid(columns: columns,
                          spacing: 16) {
                    Group {
                        Text("Home")
                            .font(
                                .system(.callout, design: .rounded)
                                .weight(.heavy)
                            )
                        
                        
                        Text("Score")
                            .font(
                                .system(.callout, design: .rounded)
                                .weight(.heavy)
                            )
                        Text("Away")
                            .font(
                                .system(.callout, design: .rounded)
                                .weight(.heavy)
                            )
                    }
                    
                    ForEach(viewStore.gameList) { game in
                        Text(game.date)
                    }
                }
                          .padding()
                          .accessibilityIdentifier("peopleGrid")
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
