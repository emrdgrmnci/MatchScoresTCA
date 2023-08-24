//
//  GamesModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

// MARK: - Games
struct GamesModel: Codable, Equatable, Identifiable, Sendable {
    var id = UUID()
    
    let data: [GameData]
    let meta: Meta
}

// MARK: - GameData
struct GameData: Codable, Equatable, Identifiable, Sendable {
    let id: Int
    let date: String
    let homeTeam: TeamsModel
    let homeTeamScore, period: Int
    let postseason: Bool
    let season: Int
    let status: Status
    let visitorTeam: TeamsModel
    let visitorTeamScore: Int

    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case period, postseason, season, status
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

enum Status: String, Codable {
    case statusFinal = "Final"
}

extension GamesModel {
    static var sample: GamesModel {
        .init(data: [GameData(id: 9, date: "12.03.2023", homeTeam: TeamsModel(data: [TeamData(id: 3, abbreviation: "LAK", city: "Los Angeles", division: "East", fullName: "Los Angeles Laker", name: "Lakers")], meta: Meta(totalPages: 206, currentPage: 1, nextPage: 2, perPage: 25, totalCount: 5130)), homeTeamScore: 100, period: 2, postseason: false, season: 20, status: Status.statusFinal, visitorTeam: TeamsModel(data: [TeamData(id: 6, abbreviation: "ORL", city: "Orlando", division: "Souteast", fullName: "Orlando Magic", name: "Orlando")], meta: Meta(totalPages: 206, currentPage: 1, nextPage: 2, perPage: 25, totalCount: 5130)), visitorTeamScore: 99)], meta: Meta(totalPages: 206, currentPage: 1, nextPage: 2, perPage: 25, totalCount: 5130))
    }
}
