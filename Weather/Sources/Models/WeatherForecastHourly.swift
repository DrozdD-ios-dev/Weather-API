//
//  WeatherForecastHourly.swift
//  Weather
//
//  Created by Дрозд Денис on 05.03.2024.
//

import Foundation

struct WeatherForecastHourly {
    let date: String
    let imageURL: URL
    let temperature: Double
}

extension WeatherForecastHourly {
    var temperatureN: String {
        return String(format: "%.0f", temperature) + "°C"
    }
}
