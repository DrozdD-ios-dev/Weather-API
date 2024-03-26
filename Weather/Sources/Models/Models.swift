//
//  VcOneModels.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let windKph: Double
    let pressureMB, humidity: Int
    let feelslikeC: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case pressureMB = "pressure_mb"
        case humidity
        case feelslikeC = "feelslike_c"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
}

enum Text: String, Codable {
    case clear = "Clear "
    case cloudy = "Cloudy "
    case lightDrizzle = "Light drizzle"
    case lightFreezingRain = "Light freezing rain"
    case lightRainShower = "Light rain shower"
    case lightRain = "Light rain"
    case lightSleet = "Light sleet"
    case lightSnowShowers = "Light snow showers"
    case moderateRain = "Moderate rain"
    case moderateSnow = "Moderate snow"
    case overcast = "Overcast "
    case partlyCloudy = "Partly cloudy"
    case textPartlyCloudy = "Partly Cloudy "
    case patchyRainNearby = "Patchy rain nearby"
    case sunny = "Sunny"
    case mist = "Mist"
    case lightSnow = "Light snow"
    case freezingFog = "Freezing fog"
    case moderateOrHeavySnowShowers = "Moderate or heavy snow showers"
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - ForecastDay
struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

// MARK: - Day
struct Day: Codable {
    let avgtempC: Double
    let avghumidity: Int
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case avgtempC = "avgtemp_c"
        case avghumidity, condition
    }
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC: Double
    let isDay: Int
    let condition: Condition
    let shortRAD, diffRAD: Double

    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case shortRAD = "short_rad"
        case diffRAD = "diff_rad"
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
