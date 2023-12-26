//
//  StatsModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 5.10.2023.
//

import Foundation

// MARK: - StatsModel
struct StatsModel: Codable, Equatable, Identifiable, Sendable {
    var id = UUID(uuidString: "3971ec05-4e53-11ze-be66-0242ac120002")
    let data: [StatsData]
    let meta: Meta?
}

// MARK: - Datum
struct StatsData: Codable, Equatable, Identifiable, Sendable {
    let id: Int?
    let ast, blk, dreb: Int?
    let fg3Pct: Double?
    let fg3A, fg3M: Int?
    let fgPct: Double?
    let fga, fgm: Int?
    let ftPct: Double?
    let fta, ftm: Int?
    let game: Game?
    let min: String?
    let oreb, pf: Int?
    let player: Player?
    let pts, reb, stl: Int?
    let team: Team?
    let turnover: Int?

    enum CodingKeys: String, CodingKey {
        case id, ast, blk, dreb
        case fg3Pct = "fg3_pct"
        case fg3A = "fg3a"
        case fg3M = "fg3m"
        case fgPct = "fg_pct"
        case fga, fgm
        case ftPct = "ft_pct"
        case fta, ftm, game, min, oreb, pf, player, pts, reb, stl, team, turnover
    }
}

// MARK: - Game
struct Game: Codable, Equatable, Identifiable, Sendable {
    let id: Int?
    let date: String?
    let homeTeamID, homeTeamScore, period: Int?
    let postseason: Bool?
    let season: Int?
//    let status: Status?
    let time: Time?
    let visitorTeamID, visitorTeamScore: Int?

    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeamID = "home_team_id"
        case homeTeamScore = "home_team_score"
        case period, postseason, season/*, status*/, time
        case visitorTeamID = "visitor_team_id"
        case visitorTeamScore = "visitor_team_score"
    }
}

enum DateEnum: String, Codable {
    case the19960204T000000000Z = "1996-02-04T00:00:00.000Z"
}

enum Time: String, Codable {
    case empty = " "
}

// MARK: - Player
struct Player: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let heightFeet, heightInches: Int?
    let position: String
    let teamID: Int
    let weightPounds: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case position
        case teamID = "team_id"
        case weightPounds = "weight_pounds"
    }
}

// MARK: - Team
struct Team: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let abbreviation, city: String
    let conference: Conference
    let division, fullName, name: String

    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, conference, division
        case fullName = "full_name"
        case name
    }
}

extension StatsModel {
    static var mockStatsModel: StatsModel {
        .init(
            data: [
                StatsData(
                    id: 13,
                    ast: 45,
                    blk: 67,
                    dreb: 67,
                    fg3Pct: 43,
                    fg3A: 345,
                    fg3M: 32,
                    fgPct: 123,
                    fga: 56,
                    fgm: 43,
                    ftPct: 46.0,
                    fta: 23,
                    ftm: 12,
                    game: Game(
                        id: 4,
                        date: "",
                        homeTeamID: 23,
                        homeTeamScore: 115,
                        period: 4,
                        postseason: true,
                        season: 2,
//                        status: Status.statusFinal,
                        time: Time.empty,
                        visitorTeamID: 12,
                        visitorTeamScore: 90
                    ),
                    min: "",
                    oreb: 0,
                    pf: 8,
                    player: Player(
                        id: 2929,
                        heightFeet: 0,
                        heightInches: 0,
                        position: "G",
                        teamID: 1,
                        weightPounds: 0
                    ),
                    pts: 6,
                    reb: 4,
                    stl: 5,
                    team: Team(
                        id: 2,
                        abbreviation: "",
                        city: "",
                        conference: Conference.east,
                        division: "",
                        fullName: "",
                        name: ""
                    ),
                    turnover: 5
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
