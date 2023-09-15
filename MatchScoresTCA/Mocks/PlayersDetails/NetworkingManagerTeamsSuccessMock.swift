//
//  NetworkingManagerTeamsSuccessMock.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 15.09.2023.
//

#if DEBUG
import Foundation

class NetworkingManagerTeamsSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        return try StaticJSONMapper.decode(file: "SingleTeamData", type: TeamsModel.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {}
}
#endif
