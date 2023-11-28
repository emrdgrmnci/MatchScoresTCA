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
            $0.homeTeam.id == homeTeamID
        }) {
            NavigationStack {
                ZStack {
                    Color.blue._300
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
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.blue, .green, .red]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .listRowBackground(Color.blue._300)
                        }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbarBackground(Color.blue._300, for: .navigationBar)
                .toolbarBackground(Color.blue._300, for: .tabBar)
                .navigationTitle(selectedGame[0].homeTeam.abbreviation)
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
