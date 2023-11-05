//
//  DateFormatter+Extension.swift
//  MatchScoresTCA
//
//  Created by emre.degirmenci on 31.10.2023.
//

import Foundation

func dateFormatter(inputDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // Input date format
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set the input timezone

    if let inputDate = dateFormatter.date(from: inputDate) {
        dateFormatter.dateFormat = "dd.MM.yyyy" // Desired output date format
        dateFormatter.timeZone = TimeZone.current // Set the desired output timezone (local)
        
        let outputDateString = dateFormatter.string(from: inputDate)
        return outputDateString // Output: 30.01.2019
    } else {
        return ""
    }
}
