//
//  TeamsModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import SwiftUI

// MARK: - Teams
struct TeamsModel: Codable, Equatable, Identifiable, Sendable {
    var id = UUID()
    
    let data: [TeamData]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case data, meta
    }
}

// MARK: - Datum
struct TeamData: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let abbreviation, city, conference: String
    let division, fullName, name: String
    
    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, division
        case fullName = "full_name"
        case name
    }
}

// MARK: - Meta
struct Meta: Codable, Equatable {
    let totalPages, currentPage, nextPage, perPage: Int
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPage = "next_page"
        case perPage = "per_page"
        case totalCount = "total_count"
    }
}

extension TeamsModel {
    static var sample: TeamsModel {
        .init(data: [
            TeamData(
                id: 1,
                abbreviation: "ATL",
                city: "Atlanta",
                conference: "East",
                division: "Southeast",
                fullName: "Atlanta Hawks",
                name: "Hawks"
            ),
            TeamData(
                id: 2,
                abbreviation: "BOS",
                city: "Boston",
                conference: "East",
                division: "Atlantic",
                fullName: "Boston Celtics",
                name: "Celtics"
            ),
            TeamData(
                id: 3,
                abbreviation: "BKN",
                city: "Brooklyn",
                conference: "East",
                division: "Atlantic",
                fullName: "Brooklyn Nets",
                name: "Nets"
            )
        ],
              meta: Meta(
                  totalPages: 2,
                  currentPage: 1,
                  nextPage: 2,
                  perPage: 30,
                  totalCount: 45
              ))
    }
}

/*
struct GameListView: View {
    let store: StoreOf<GameListFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                ZStack {
                    Color.blue._50
                        .edgesIgnoringSafeArea(.all)
                    List(viewStore.searchResults) { game in
                        ZStack {
                            NavigationLink(destination: GameDetailView(
                                games: viewStore.games,
                                homeTeamID: game.homeTeam.id,
                                visitorTeamID: game.visitorTeam.id
                            )) {
                                EmptyView()
                            }.opacity(0.0)
                            VStack(alignment: .center) {
                                Text(dateFormatter(inputDate: game.date))
                                    .font(.subheadline)
                                
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
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
                            }
                        }
                        .listRowBackground(Color.blue._50)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                    .scrollContentBackground(.hidden)
                }
                .searchable(
                    text: viewStore.binding(
                        get: \.searchQuery, send: GameListFeature.Action.searchQueryChanged
                    ),
                    placement: .automatic,
                    prompt: "Search All NBA Competitions"
                )
                .toolbarBackground(Color.blue._50, for: .navigationBar)
                .toolbarBackground(Color.blue._50, for: .tabBar)
                .frame(maxWidth: .infinity)
                .refreshable {
                    viewStore.send(.onAppear)
                }
                .navigationTitle("Games")
                .onAppear {
                    viewStore.send(.onAppear)
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
*/
