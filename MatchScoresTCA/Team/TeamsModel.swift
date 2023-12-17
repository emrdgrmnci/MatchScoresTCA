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

extension TeamData: Comparable {
    static func < (lhs: TeamData, rhs: TeamData) -> Bool {
        return lhs.name > rhs.name
    }
}

// MARK: - Meta
struct Meta: Codable, Equatable {
    let totalPages, currentPage, nextPage, perPage: Int?
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
        return TeamsModel(
            id: UUID(uuidString: "12345678-1234-1234-1234-1234567890ab")!,
            data: [
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
            ),
            TeamData(
                id: 4,
                abbreviation: "CHA",
                city: "Charlotte",
                conference: "East",
                division: "Southeast",
                fullName: "Charlotte Hornets",
                name: "Hornets"
            ),
            TeamData(
                id: 5,
                abbreviation: "CHI",
                city: "Chicago",
                conference: "East",
                division: "Central",
                fullName: "Chicago Bulls",
                name: "Bulls"
            ),
            TeamData(
                id: 6,
                abbreviation: "CLE",
                city: "Cleveland",
                conference: "East",
                division: "Central",
                fullName: "Cleveland Cavaliers",
                name: "Cavaliers"
            ),
            TeamData(
                id: 7,
                abbreviation: "DAL",
                city: "Dallas",
                conference: "West",
                division: "Southwest",
                fullName: "Dallas Mavericks",
                name: "Mavericks"
            ),
            TeamData(
                id: 8,
                abbreviation: "DEN",
                city: "Denver",
                conference: "West",
                division: "Northwest",
                fullName: "Denver Nuggets",
                name: "Nuggets"
            ),
            TeamData(
                id: 9,
                abbreviation: "DET",
                city: "Detroit",
                conference: "East",
                division: "Central",
                fullName: "Detroit Pistons",
                name: "Pistons"
            ),
            TeamData(
                id: 10,
                abbreviation: "GSW",
                city: "Golden State",
                conference: "West",
                division: "Pacific",
                fullName: "Golden State Warriors",
                name: "Warriors"
            ),
            TeamData(
                id: 11,
                abbreviation: "HOU",
                city: "Houston",
                conference: "West",
                division: "Southwest",
                fullName: "Houston Rockets",
                name: "Rockets"
            ),
            TeamData(
                id: 12,
                abbreviation: "IND",
                city: "Indiana",
                conference: "East",
                division: "Central",
                fullName: "Indiana Pacers",
                name: "Pacers"
            ),
            TeamData(
                id: 13,
                abbreviation: "LAC",
                city: "LA",
                conference: "West",
                division: "Pacific",
                fullName: "LA Clippers",
                name: "Clippers"
            ),
            TeamData(
                id: 14,
                abbreviation: "LAL",
                city: "Los Angeles",
                conference: "West",
                division: "Pacific",
                fullName: "Los Angeles Lakers",
                name: "Lakers"
            ),
            TeamData(
                id: 15,
                abbreviation: "MEM",
                city: "Memphis",
                conference: "West",
                division: "Southwest",
                fullName: "Memphis Grizzlies",
                name: "Grizzlies"
            ),
            TeamData(
                id: 16,
                abbreviation: "MIA",
                city: "Miami",
                conference: "East",
                division: "Southeast",
                fullName: "Miami Heat",
                name: "Heat"
            ),
            TeamData(
                id: 17,
                abbreviation: "MIL",
                city: "Milwaukee",
                conference: "East",
                division: "Central",
                fullName: "Milwaukee Bucks",
                name: "Bucks"
            ),
            TeamData(
                id: 18,
                abbreviation: "MIN",
                city: "Minnesota",
                conference: "West",
                division: "Northwest",
                fullName: "Minnesota Timberwolves",
                name: "Timberwolves"
            ),
            TeamData(
                id: 19,
                abbreviation: "NOP",
                city: "New Orleans",
                conference: "West",
                division: "Southwest",
                fullName: "New Orleans Pelicans",
                name: "Pelicans"
            ),
            TeamData(
                id: 20,
                abbreviation: "NYK",
                city: "New York",
                conference: "East",
                division: "Atlantic",
                fullName: "New York Knicks",
                name: "Knicks"
            ),
            TeamData(
                id: 21,
                abbreviation: "OKC",
                city: "Oklahoma City",
                conference: "West",
                division: "Northwest",
                fullName: "Oklahoma City Thunder",
                name: "Thunder"
            ),
            TeamData(
                id: 22,
                abbreviation: "ORL",
                city: "Orlando",
                conference: "East",
                division: "Southeast",
                fullName: "Orlando Magic",
                name: "Magic"
            ),
            TeamData(
                id: 23,
                abbreviation: "PHI",
                city: "Philadelphia",
                conference: "East",
                division: "Atlantic",
                fullName: "Philadelphia 76ers",
                name: "76ers"
            ),
            TeamData(
                id: 24,
                abbreviation: "PHX",
                city: "Phoenix",
                conference: "West",
                division: "Pacific",
                fullName: "Phoenix Suns",
                name: "Suns"
            ),
            TeamData(
                id: 25,
                abbreviation: "POR",
                city: "Portland",
                conference: "West",
                division: "Atlantic",
                fullName: "Brooklyn Nets",
                name: "Nets"
            ),
            TeamData(
                id: 26,
                abbreviation: "SAC",
                city: "Sacramento",
                conference: "West",
                division: "Pacific",
                fullName: "Sacramento Kings",
                name: "Kings"
            ),
            TeamData(
                id: 27,
                abbreviation: "SAS",
                city: "San Antonio",
                conference: "West",
                division: "Southwest",
                fullName: "San Antonio Spurs",
                name: "Spurs"
            ),
            TeamData(
                id: 28,
                abbreviation: "TOR",
                city: "Toronto",
                conference: "East",
                division: "Atlantic",
                fullName: "Toronto Raptors",
                name: "Raptors"
            ),
            TeamData(
                id: 29,
                abbreviation: "UTA",
                city: "Utah",
                conference: "West",
                division: "Northwest",
                fullName: "Utah Jazz",
                name: "Jazz"
            ),
            TeamData(
                id: 30,
                abbreviation: "WAS",
                city: "Washington",
                conference: "East",
                division: "Southeast",
                fullName: "Washington Wizards",
                name: "Wizards"
            )
        ],
              meta: Meta(
                  totalPages: 2,
                  currentPage: 1,
                  nextPage: 2,
                  perPage: 30,
                  totalCount: 45
              )
        )
    }
}
