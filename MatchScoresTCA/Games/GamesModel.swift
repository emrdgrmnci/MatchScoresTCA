//
//  GamesModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

// MARK: - Games
struct GamesModel: Codable, Equatable, Identifiable, Sendable {
    var id = UUID(uuidString: "3971cc04-4e50-11ee-be56-0242ac120002")
    let data: [GameData]
    let meta: Meta
}

// MARK: - GameData
struct GameData: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let date: String
    let homeTeam: TeamData
    let homeTeamScore, period: Int
    let postseason: Bool
    let season: Int
//    let status: Status
    let visitorTeam: TeamData
    let visitorTeamScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case period, postseason, season/*, status*/
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
}

enum Conference: String, Codable {
    case east = "East"
    case empty = "    "
    case west = "West"
}

enum Division: String, Codable {
    case atlantic = "Atlantic"
    case central = "Central"
    case empty = ""
    case pacific = "Pacific"
    case southeast = "Southeast"
    case southwest = "Southwest"
    case northwest = "Northwest"
    case northeast = "Northeast"
}

//enum Status: String, Codable {
//    case statusFinal = "Final"
//}

extension GamesModel {
    static var sample: GamesModel {
        return GamesModel(
            id: UUID(uuidString: "12345678-1234-1234-1234-1234567890ab")!,
            data: [
            GameData(
                id: 2,
                date: "12.02.2019",
                homeTeam: TeamData(
                    id: 1,
                    abbreviation: "ATL",
                    city: "Atlanta",
                    conference: "East",
                    division: "Southeast",
                    fullName: "Atlanta Hawks",
                    name: "Hawks"
                ),
                homeTeamScore: 102,
                period: 2,
                postseason: true,
                season: 4,
//                status: Status.statusFinal,
                visitorTeam: TeamData(
                    id: 2,
                    abbreviation: "BOS",
                    city: "Boston",
                    conference: "East",
                    division: "Atlantic",
                    fullName: "Boston Celtics",
                    name: "Celtics"
                ),
                visitorTeamScore: 99)
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
