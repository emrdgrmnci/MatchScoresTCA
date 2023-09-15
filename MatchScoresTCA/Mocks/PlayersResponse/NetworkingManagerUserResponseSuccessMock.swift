//
//  NetworkingManagerUserResponseSuccessMock.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 15.09.2023.
//

#if DEBUG
import Foundation

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "TeamsStaticData", type: TeamsModel.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws { }
}
#endif
