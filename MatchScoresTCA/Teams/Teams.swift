//
//  Teams.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation

// MARK: - Teams
struct Teams: Codable, Equatable {
    let data: [Datum]
    let meta: Meta
}

// MARK: - Datum
struct Datum: Codable, Equatable {
    let id: Int
    let abbreviation, city: String
    let division, fullName, name: String

    enum CodingKeys: String, CodingKey {
        case id, abbreviation, city, division
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

