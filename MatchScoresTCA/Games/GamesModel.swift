//
//  GamesModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.08.2023.
//

import SwiftUI

// MARK: - Games
struct GamesModel: Codable, Equatable, Identifiable, Sendable {
    
    var id = UUID().uuidString
    let data: [GameData]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case data, meta
    }
}

// MARK: - GameData
struct GameData: Codable, Equatable, Identifiable, Sendable, Hashable {
    let id: Int
    let date: String
    let homeTeam: TeamData
    let homeTeamScore, period: Int
    let postseason: Bool
    let season: Int
    let status: Status
    let visitorTeam: TeamData
    let visitorTeamScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case period, postseason, season, status
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

enum Conference: String, Codable, Equatable {
    case east = "East"
    case empty = "    "
    case west = "West"
}

enum Division: String, Codable, Equatable {
    case atlantic = "Atlantic"
    case central = "Central"
    case empty = ""
    case pacific = "Pacific"
    case southeast = "Southeast"
    case southwest = "Southwest"
    case northwest = "Northwest"
    case northeast = "Northeast"
}

enum Status: String, Codable, Equatable {
    case statusFinal = "Final"
}

extension GamesModel {
    static var sample: GamesModel {
        .init(data: [GameData(id: 9, date: "12.03.2023", homeTeam: TeamData(id: 3, abbreviation: "LAK", city: "Los Angeles", division: "East", fullName: "Los Angeles Laker", name: "Lakers"), homeTeamScore: 100, period: 2, postseason: false, season: 20, status: .statusFinal, visitorTeam: TeamData(id: 3, abbreviation: "LAK", city: "Los Angeles", division: "East", fullName: "Los Angeles Laker", name: "Lakers"), visitorTeamScore: 99)], meta: Meta(totalPages: 206, currentPage: 1, nextPage: 2, perPage: 25, totalCount: 5130))
        
    }
}
