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
    
//    let season: Int
//    let userId: Int
    
    let columns = Array(repeating: GridItem(.flexible()),
                        count: 3)
    
//    init(season: Int, userId: Int) {
//        self.season = season
//        self.userId = userId
//    }
    
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
                    
//                    ForEach(viewStore.gameList) { game in
//                        //                        ForEach(game.homeTeam.data) { data in
//                        //                        Text(game.homeTeam.data.first!.abbreviation)
//                        //                            .font(
//                        //                                .system(.subheadline, design: .rounded)
//                        //                            )
//
//                        //                        Text("\(game.homeTeamScore) - \(game.visitorTeamScore)")
//                        //                            .font(
//                        //                                .system(.subheadline, design: .rounded)
//                        //                            )
//
//                        Text(game.visitorTeam.abbreviation)
//                            .font(
//                                .system(.subheadline, design: .rounded)
//                            )
//                        //                    }
//                    }
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
