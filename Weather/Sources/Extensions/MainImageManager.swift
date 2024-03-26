//
//  MainImageManager.swift
//  Weather
//
//  Created by Дрозд Денис on 26.03.2024.
//

import UIKit

final class MainImageManager {
    
    static func selectImageDay(model: Weather) -> UIImageView {
        let image = UIImageView()
        switch model.current.condition.text {
            
        case "Sunny", "Partly Cloudy ":
            image.image = UIImage(named: "SunnyDay")
            
        case "Clear ":
            image.image = UIImage(named: "ClearDay")
            
        case "Cloudy ", "Overcast ", "Partly cloudy":
            image.image = UIImage(named: "CloudDay")
            
        case "Light drizzle", "Light freezing rain", "Light sleet", "Light rain", "Light rain shower":
            image.image = UIImage(named: "LightRain")
            
        case "Moderate rain", "Patchy rain nearby":
            image.image = UIImage(named: "Rain")
            
        case "Light snow showers", "Moderate snow", "Light snow", "Moderate or heavy snow showers":
            image.image = UIImage(named: "SnowDay")
            
        case "Mist", "Fog", "Freezing fog":
            image.image = UIImage(named: "MistDay")
            
        default: break
        }
        return image
    }
    
    static func selectImageNight(model: Weather) -> UIImageView {
        let image = UIImageView()
        switch model.current.condition.text {
            
        case "Sunny", "Partly Cloudy ":
            image.image = UIImage(named: "SunnyDay")
            
        case "Clear ":
            image.image = UIImage(named: "ClearNight")
            
        case "Cloudy ", "Overcast ", "Partly cloudy":
            image.image = UIImage(named: "CloudNight")
            
        case "Light drizzle", "Light freezing rain", "Light sleet", "Light rain", "Light rain shower":
            image.image = UIImage(named: "LightRain")
            
        case "Moderate rain", "Patchy rain nearby":
            image.image = UIImage(named: "Rain")
            
        case "Light snow showers", "Moderate snow", "Light snow", "Moderate or heavy snow showers":
            image.image = UIImage(named: "SnowNight")
            
        case "Mist", "Fog", "Freezing fog":
            image.image = UIImage(named: "MistNight")
            
        default: break
        }
        return image
    }
}
