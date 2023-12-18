//
//  APIError.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 6.08.2023.
//

import Foundation

enum APIError: Error {
  case downloadError
  case decodingError
}

extension APIError: Equatable { }
