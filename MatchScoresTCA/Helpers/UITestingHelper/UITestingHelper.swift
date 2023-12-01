//
//  UITestingHelper.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 12.10.2023.
//

#if DEBUG

import Foundation

struct UITestingHelper {
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
}

#endif
