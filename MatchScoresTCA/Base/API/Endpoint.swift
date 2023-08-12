//
//  Endpoint.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation

enum Endpoint {
    case teams
    case games
    case players
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    
    var host: String { "www.balldontlie.io" }
    
    var path: String {
        switch self {
        case .teams:
            return "/api/v1/teams"
        case .games:
            return "/api/v1/games"
        case .players:
            return "/api/v1/players"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .teams:
            return .GET
        case .games:
            return .GET
        case .players:
            return .GET
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .teams:
            return nil
        default:
            return nil
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
#if DEBUG
        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
#endif
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
