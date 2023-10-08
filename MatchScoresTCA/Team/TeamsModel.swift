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
