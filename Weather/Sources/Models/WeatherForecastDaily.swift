//
//  WeatherForecastDaily.swift
//  Weather
//
//  Created by Дрозд Денис on 05.03.2024.
//

import Foundation

struct WeatherForecastDaily {
    let date: String
    let imageURL: URL
    let dayTemperature: Double
    let nightTemperature: Double
}

extension WeatherForecastDaily {
    var dayTemperatureN: String {
        return String(format: "%.0f", dayTemperature) + "°C"
    }
    
    var nightTemperatureN: String {
        return String(format: "%.0f", nightTemperature - 2.5) + "°C"
    }
}
