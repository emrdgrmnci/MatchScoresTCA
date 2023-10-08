//
//  String+Extension.swift
//  MatchScoresTCA
//
//  Created by Emre on 8.10.2023.
//

import Foundation

extension String {
    func dateFormatter(inputDate: Self) -> Self {
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
}
