//
//  StatsModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 5.10.2023.
//

import Foundation

// MARK: - Stats
struct StatsModel: Codable, Equatable, Identifiable, Sendable {
    var id = UUID(uuidString: "3971cc04-4e77-31ee-be56-0442ac120502")
    let data: [StatsData]
    let meta: Meta
}

// MARK: - Datum
struct StatsData: Codable, Equatable, Identifiable, Sendable {
    let id, ast: Int
    let fgPct: Double
    let fga, fgm: Int
    let ftPct: Double?
    let fta, ftm: Int
    let game: Game
    let min: String
    let pf: Int
    let player: Player
    let pts, reb: Int
    let team: Team
    
    enum CodingKeys: String, CodingKey {
        case id, ast
        case fgPct = "fg_pct"
        case fga, fgm
        case ftPct = "ft_pct"
        case fta, ftm, game, min, pf, player, pts, reb, team
    }
}

// MARK: - Game
struct Game: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let date: DateEnum
    let homeTeamID, homeTeamScore, period: Int
    let postseason: Bool
    let season: Int
    let status: Status
    let visitorTeamID, visitorTeamScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeamID = "home_team_id"
        case homeTeamScore = "home_team_score"
        case period, postseason, season, status
        case visitorTeamID = "visitor_team_id"
        case visitorTeamScore = "visitor_team_score"
    }
}

enum DateEnum: String, Codable {
    case the19691128T000000000Z = "1969-11-28T00:00:00.000Z"
}

// MARK: - Player
struct Player: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let firstName: String
    let lastName, position: String
    let teamID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case position
        case teamID = "team_id"
    }
}

// MARK: - Team
struct Team: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let abbreviation, city: String
    let conference: Conference
    let division: Division
    let fullName, name: String
    
    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, division
        case fullName = "full_name"
        case name
    }
}

extension StatsModel {
    static var sample: StatsModel {
        .init(
            data: [
                StatsData(
                    id: 13,
                    ast: 45,
                    fgPct: 67,
                    fga: 87,
                    fgm: 90,
                    ftPct: 5.0,
                    fta: 111,
                    ftm: 232,
                    game: Game(
                        id: 13,
                        date: DateEnum.the19691128T000000000Z,
                        homeTeamID: 25,
                        homeTeamScore: 100,
                        period: 4,
                        postseason: false,
                        season: 3,
                        status: Status.statusFinal,
                        visitorTeamID: 15,
                        visitorTeamScore: 130
                    ),
                    min: "",
                    pf: 0,
                    player: Player(
                        id: 47,
                        firstName: "Jabari",
                        lastName: "Bird",
                        position: "G",
                        teamID: 15
                    ),
                    pts: 30,
                    reb: 30,
                    team: Team(
                        id: 15,
                        abbreviation: "MEM",
                        city: "Memphis",
                        conference: Conference(rawValue: "West") ?? Conference.east,
                        division: Division(rawValue: "Southwest") ?? Division.atlantic,
                        fullName: "Memphis Grizzlies",
                        name: "Grizzlies")
                )
            ],
            meta: Meta(
                totalPages: 206,
                currentPage: 1,
                nextPage: 2,
                perPage: 25,
                totalCount: 5130
            )
        )
    }
}
