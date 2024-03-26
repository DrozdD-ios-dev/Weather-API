//
//  Formatter.swift
//  Weather
//
//  Created by Дрозд Денис on 25.03.2024.
//

import Foundation

final class Formatter {
    
    static func convertDateToCustomFormat(_ inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: inputDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM"
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
}
