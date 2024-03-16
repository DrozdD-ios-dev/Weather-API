//
//  ModelSearchCity.swift
//  Weather
//
//  Created by Дрозд Денис on 04.03.2024.
//

import Foundation

// MARK: - WelcomeElement
struct SearchCity: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let url: String
}
