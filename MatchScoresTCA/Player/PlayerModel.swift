//
//  PlayerModel.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import Foundation

// MARK: - Players
struct PlayersModel: Decodable, Equatable, Sendable {
    let data: [PlayerData]
    let meta: Meta
}

// MARK: - Datum
struct PlayerData: Decodable, Equatable, Identifiable, Sendable {
    let id: Int
    let firstName: String
    let heightFeet, heightInches: Int?
    let lastName, position: String
    let team: TeamData
    let weightPounds: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case lastName = "last_name"
        case position, team
        case weightPounds = "weight_pounds"
    }
}

extension PlayersModel {
    static var sample: PlayersModel {
        .init(
            data: [
                PlayerData(
                    id: 14,
                    firstName: "Ike",
                    heightFeet: nil,
                    heightInches: nil,
                    lastName: "Anigbogu",
                    position: "C",
                    team:
                        TeamData(
                            id: 12,
                            abbreviation: "IND",
                            city: "Indiana",
                            division: "Central",
                            fullName: "Indiana Pacers",
                            name: "Pacers"),
                    weightPounds: nil
                ),
                
                PlayerData(
                    id: 25,
                    firstName: "Ron",
                    heightFeet: nil,
                    heightInches: nil,
                    lastName: "Baker",
                    position: "G",
                    team:
                        TeamData(
                            id: 20,
                            abbreviation: "NYK",
                            city: "New York",
                            division: "Atlantic",
                            fullName: "New York Knicks",
                            name: "Knicks"),
                    weightPounds: nil
                ),
                
                PlayerData(
                    id: 47,
                    firstName: "Jabari",
                    heightFeet: nil,
                    heightInches: nil,
                    lastName: "Bird",
                    position: "G",
                    team:
                        TeamData(
                            id: 15,
                            abbreviation: "MEM",
                            city: "Memphis",
                            division: "Southwest",
                            fullName: "Memphis Grizzlies",
                            name: "Grizzlies"),
                    weightPounds: nil)
            ], meta:
                Meta(
                    totalPages: 206,
                    currentPage: 1,
                    nextPage: 2,
                    perPage: 25,
                    totalCount: 5130
                )
        )
    }
}
