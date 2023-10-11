//
//  GameDetailView.swift
//  MatchScoresTCA
//
//  Created by Emre on 1.10.2023.
//

import SwiftUI
import ComposableArchitecture

struct GameDetailView: View {
    
    @State private var isShowingBottomSheet = false
    @State private var selectedFilter = "All"
    
    var games: [GameData]?
    var homeTeamID: Int
    var visitorTeamID: Int
    
    var body: some View {
        if let selectedGame = games?.filter ({
            $0.homeTeam.id == homeTeamID ||
            $0.visitorTeam.id == visitorTeamID
        }) {
            NavigationStack {
                ZStack {
                    Color.blue._50
                        .edgesIgnoringSafeArea(.all)
                    List(selectedGame) { game in
                            VStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 24) {
                                    Text(dateFormatter(inputDate: game.date))
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 24) {
                                    VStack {
                                        Image(avatars[game.visitorTeam.id - 1])
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                        Text(game.visitorTeam.name)
                                            .font(.callout)
                                    }
                                    .frame(width: 65)
                                    
                                    HStack {
                                        Text("\(game.visitorTeamScore)")
                                            .font(.callout)
                                        
                                        Text("-")
                                            .font(.callout)
                                        
                                        Text("\(game.homeTeamScore)")
                                            .font(.callout)
                                    }
                                    
                                    VStack {
                                        Image(avatars[game.homeTeam.id - 1])
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                        Text(game.homeTeam.name)
                                            .font(.callout)
                                    }
                                    .frame(width: 65)
                                }
                                .padding()
                            }
                            .listRowBackground(Color.blue._50)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
                .navigationTitle(selectedGame[0].homeTeam.abbreviation)
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Menu {
//                            ForEach([selectedGame[0].homeTeam.fullName], id: \.self) { team in
//                                Button {
//                                    selectedFilter = team
//                                } label: {
//                                    Text(team)
//                                }
//                            }
//                        }
//                    label: {
//                        Label("Add", systemImage: "line.3.horizontal.decrease.circle.fill")
//                    }
//                }
//            }
        }
    }
}

private extension GameListView {
    var refresh: some View {
        Button {
            Task {
                // await vm.fetchTeams()
            }
        } label: {
            Symbols.refresh
        }
        // .disabled(vm.isLoading)
    }
}
