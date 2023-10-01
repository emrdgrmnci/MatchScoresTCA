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
//                                .frame(maxWidth: .infinity)
                                .padding()
                            }
                            .listRowBackground(Color.blue._50)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
//                .frame(maxWidth: .infinity)
                .navigationTitle(selectedGame[0].homeTeam.abbreviation)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            ForEach([selectedGame[0].homeTeam.fullName], id: \.self) { team in
                                Button {
                                    selectedFilter = team
                                } label: {
                                    Text(team)
                                }
                            }
                        }
                    label: {
                        Label("Add", systemImage: "line.3.horizontal.decrease.circle.fill")
                    }
                }
            }
        }
    }
    
    private func dateFormatter(inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // Input date format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set the input timezone
        
        if let inputDate = dateFormatter.date(from: inputDate) {
            dateFormatter.dateFormat = "dd.MM.yyyy" // Desired output date format
            dateFormatter.timeZone = TimeZone.current // Set the desired output timezone (local)
            
            let outputDateString = dateFormatter.string(from: inputDate)
            return outputDateString // Output: 30.01.2019
        } else {
            return ""
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
