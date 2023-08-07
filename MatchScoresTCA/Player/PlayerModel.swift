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
//    let team: TeamsModel
    let weightPounds: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case heightFeet = "height_feet"
        case heightInches = "height_inches"
        case lastName = "last_name"
        case position
        case weightPounds = "weight_pounds"
    }
}

extension PlayersModel {
    static var sample: [PlayerData] {
        [
            .init(
                id: 14,
                firstName: "Ike",
                heightFeet: nil,
                heightInches: nil,
                lastName: "Anigbogu",
                position: "C",
                weightPounds: nil
            ),
            .init(
                id: 25,
                firstName: "Ron",
                heightFeet: nil,
                heightInches: nil,
                lastName: "Baker",
                position: "G",
                weightPounds: nil
            ),
            .init(
                id: 47,
                firstName: "Jabari",
                heightFeet: nil,
                heightInches: nil,
                lastName: "Bird",
                position: "G",
                weightPounds: nil
            )
        ]
    }
}


