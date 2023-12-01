//
//  MatchScoresLogger.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 30.11.2023.
//

import Foundation
import OSLog

public struct MatchScoresLogger {
    /// Debug: Useful only during debugging - Not persistent
    /// Info: Helping but not essential for troubleshooting - Persistent only during log collect
    /// Notice (Default): Essential for troubleshooing - Persistent up to a storage limit
    /// Error: Error seen during execution - Persistent up to a storage limit
    /// Fault: Bug in program -  Persistent up to a storage limit
    public enum LogLevel { case debug, info, notice, error, fault }

    public static func log(_ content: Any, stream: Logger = .viewCycle, level: LogLevel = .notice) {
        let emoji: String
        switch level {
        case .debug:
            emoji = "🔍"
        case .info:
            emoji = "ℹ️"
        case .notice:
            emoji = "📢"
        case .error:
            emoji = "❗️"
        case .fault:
            emoji = "💥"
        }
        
        let contentWithEmoji = "\(emoji) \(String(describing: content))"
        
        switch level {
        case .debug:
            stream.debug("\(contentWithEmoji)")
        case .info:
            stream.info("\(contentWithEmoji)")
        case .notice:
            stream.notice("\(contentWithEmoji)")
        case .error:
            stream.error("\(contentWithEmoji)")
        case .fault:
            stream.fault("\(contentWithEmoji)")
        }
    }

    private init() {}
}

public extension Logger {
    static var subsystem = Bundle.main.bundleIdentifier ?? "com.emre.MatchScore"
    static let viewCycle = Logger(subsystem: subsystem, category: "viewCycle")
    static let network = Logger(subsystem: subsystem, category: "network")
    static let database = Logger(subsystem: subsystem, category: "database")
}
