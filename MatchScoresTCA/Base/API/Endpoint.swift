//
//  Endpoint.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 4.08.2023.
//

import Foundation

enum Endpoint {
    case teams(page: Int)
    case games
    case players(page: Int)
    case stats(String)
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
            case .stats:
                return "/api/v1/stats"
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
            case .stats:
                return .GET
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
            case let .teams(page):
                return [
                    "page": "\(page)"
                ]
            case let .players(page):
                return [
                    "page": "\(page)"
                ]
            case let .stats(playerID):
                return [
                    "player_ids[]": playerID
                ]
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
        
        //#if DEBUG
        //        requestQueryItems.append(URLQueryItem(name: "delay", value: "2"))
        //#endif
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
