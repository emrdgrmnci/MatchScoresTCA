//
//  NetworkingManagerCreateSuccessMock.swift
//  MatchScoresTCATests
//
//  Created by emre.degirmenci on 15.09.2023.
//

#if DEBUG
import Foundation

class NetworkingManagerCreateSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {}
}
#endif
