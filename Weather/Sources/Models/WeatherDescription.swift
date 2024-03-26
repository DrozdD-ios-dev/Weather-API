//
//  WeatherDescription.swift
//  Weather
//
//  Created by Дрозд Денис on 01.03.2024.
//

import Foundation

struct WeatherDescription {
    let region: String
    let temperature: Double
    let imageURL: URL
    let currentWeather: String
    let feelsAs: Double
    let windSpeed: Double
    let humidity: Int
    let pressure: Int
}

extension WeatherDescription {
    var feelsAsN: String {
        return  "Ощущается как: \(feelsAs)°C"
    }
    
    var windSpeedN: String {
        return "Скорость ветра \(String(windSpeed)) м/с"
    }
    
    var humidityN: String {
        return "Влажность воздуха \(humidity)%"
    }
    
    var pressureN: String {
        return "Атм. давление: \(pressure) mm"
    }
    
    var temperatureN: String {
        return String(format: "%.0f", temperature) + "°C"
    }
    
    var currentWeatherN: String {
        return NSLocalizedString("\(currentWeather)", comment: "")
    }
}
