//
//  TeamsModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import SwiftUI

// MARK: - Teams
struct TeamsModel: Decodable, Equatable, Sendable {
    let data: [TeamData]
    let meta: Meta
}

// MARK: - Datum
struct TeamData: Decodable, Equatable, Identifiable, Sendable {
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
struct Meta: Decodable, Equatable {
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
            TeamData(id: 1, abbreviation: "ATL", city: "Atlanta", division: "Southeast", fullName: "Atlanta Hawks", name: "Hawks"),
            
            TeamData(id: 2, abbreviation: "BOS", city: "Boston", division: "Atlantic", fullName: "Boston Celtics", name: "Celtics"),
            
            TeamData(id: 3, abbreviation: "BKN", city: "Brooklyn", division: "Atlantic", fullName: "Brooklyn Nets", name: "Nets")
        ],
              meta: Meta(totalPages: 2, currentPage: 1, nextPage: 2, perPage: 30, totalCount: 45))
        
    }
}
