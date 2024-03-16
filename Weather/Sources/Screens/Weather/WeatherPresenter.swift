//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

protocol WeatherPresentationProtocol: AnyObject {
    var forecastHourly: [WeatherForecastHourly] { get }
    var forecastDaily: [WeatherForecastDaily] { get }
    
    func downloadData(weather: Weather)
    
    func getData(parameter: String)
    func getDataOneCity(with: String)
    func searchCity(with: String)
    func sentCitys(with: [String])
}


final class WeatherPresenter: WeatherPresentationProtocol {
    
    // MARK: - Properties
    
    weak var viewController: WeatherViewProtocol?
    let router: WeatherRouterProtocol
    let interactor: WeatherInteractorProtocol
    
    var forecastHourly: [WeatherForecastHourly] = []
    var forecastDaily: [WeatherForecastDaily] = []
    
    // MARK: - Init
    
    init(interactor: WeatherInteractorProtocol, router: WeatherRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Create
    var cityArray = [String]()
    
    // MARK: - Public Functions
    
    func getData(parameter: String) {
        interactor.getData(parameter: parameter)
    }
    
    func searchCity(with: String) {
        interactor.searchCity(with: with)
    }
    
    func getDataOneCity(with: String) {
        interactor.getData(parameter: with)
    }
    
    // MARK: - Interactor Calls
    
    func downloadData(weather: Weather) {
        
        forecastHourly = []
        forecastDaily = []
        
        // Отображаем данные на WeatherDescriptionView
        
        let windSpeed = (weather.current.windKph * 0.27778 * 10).rounded() / 10
        
        let model = WeatherDescription(
            region: "\(weather.location.name), \(weather.location.country)",
            temperature: String("\(weather.current.tempC)°C"),
            imageURL: weather.current.condition.icon.toURLWithHTTPS(),
            currentWeather: NSLocalizedString("\(weather.current.condition.text)", comment: ""),
            feelsAs: "Ощущается как: \(weather.current.feelslikeC)°C",
            windSpeed: "Скорость ветра \(String(windSpeed)) м/с",
            humidity: "Влажность воздуха \(weather.current.humidity)%",
            pressure: "Атм. давление: \(weather.current.pressureMB) mm"
        )
        
        DispatchQueue.main.async {
            self.viewController?.setWeatherDescriptionView(with: model)
        }
        
        // Отображаем данные на коллекции
        
        for hour in weather.forecast.forecastday[0].hour[0..<24] {
            let model = WeatherForecastHourly(
                date: hour.time.removeFirstCharacters(11),
                imageURL: hour.condition.icon.toURLWithHTTPS(),
                temperature: String(hour.tempC) + "°C"
            )
            forecastHourly.append(model)
        }
        
        DispatchQueue.main.async {
            self.viewController?.reloadCollectionViewData()
        }
        
        // Отображаем данные в талице
        
        for forecast in weather.forecast.forecastday {
            let model = WeatherForecastDaily(
                date: convertDateToCustomFormat(forecast.date),
                imageURL: forecast.day.condition.icon.toURLWithHTTPS(),
                dayTemperature: String(format: "%.1f", forecast.day.avgtempC),
                nightTemperature: String(format: "%.1f", forecast.day.avgtempC - 2.5)
            )
            forecastDaily.append(model)
        }
        
        DispatchQueue.main.async {
            self.viewController?.reloadTableViewData()
        }
        
        // Выбор отображения фоновой картинки
        DispatchQueue.main.async {
            if weather.current.isDay == 1 {
                self.selectImageDay(with: weather) // Day
            } else {
                self.selectImageNight(with: weather) // Night
            }
        }
    }
    
    func sentCitys(with: [String]) {
        viewController?.sentCitys(with: with)
//        print("Presenter print (with) \(with)")
    }
    
    // MARK: - Private Functions
    
    private func convertDateToCustomFormat(_ inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: inputDate) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM"
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
    
    private func selectImageDay(with: Weather) {
        let image = UIImageView()
        switch with.current.condition.text {
            
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
        self.viewController?.reloadViewMain(with: image.image ?? UIImage())
    }
    
    private func selectImageNight(with: Weather) {
        let image = UIImageView()
        switch with.current.condition.text {
            
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
        self.viewController?.reloadViewMain(with: image.image ?? UIImage())
    }
    
}
