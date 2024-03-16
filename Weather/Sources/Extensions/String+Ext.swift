//
//  String+Ext.swift
//  Weather
//
//  Created by Дрозд Денис on 01.03.2024.
//

import Foundation

extension String {
    
    func toURLWithHTTPS() -> URL {
        return URL(string: "https:\(self)")!
    }
    
    func removeFirstCharacters(_ amount: Int) -> String {
        guard count >= amount else {
            return self
        }
        let indexTo = index(self.startIndex, offsetBy: amount)
        let result = String(self[indexTo...])
        return result
    }
}
