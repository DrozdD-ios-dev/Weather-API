//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

// MARK: - Protocol

protocol WeatherPresentationProtocol: AnyObject {
    var forecastHourly: [WeatherForecastHourly] { get }
    var forecastDaily: [WeatherForecastDaily] { get }
    func downloadData(weather: Weather)
    
    func getData(parameter: String)
    func getDataOneCity(with: String)
    func searchCity(with: String)
    func sentCitys(with: [String])
    func passError(code: String)
    func getLocate()
}

final class WeatherPresenter: WeatherPresentationProtocol {
    
    // MARK: - Properties
    
    weak var viewController: MainScreenViewProtocol?
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
    
    func passError(code: String) {
        DispatchQueue.main.async {
            self.viewController?.newError(text: code)
        }
    }
    
    func getData(parameter: String) {
        interactor.getData(parameter: parameter)
    }
    
    func searchCity(with: String) {
        interactor.searchCity(with: with)
    }
    
    func getDataOneCity(with: String) {
        interactor.getData(parameter: with)
    }
    
    // MARK: - Locate
    
    func getLocate() {
        let locateManager = LocateManager.shared.getLocation()
        getData(parameter: locateManager)
    }
    
    // MARK: - Interactor Calls
    
    func downloadData(weather: Weather) {
        setMainData(model: weather)
        setWeatherDescriptin(model: weather)
        setTabelViewData(model: weather)
        selectMainImage(model: weather)
    }
    
    func setMainData(model: Weather) {
        forecastHourly = []
        forecastDaily = []
        
        let windSpeed = (model.current.windKph * 0.27778 * 10).rounded() / 10
        let modelWeather = WeatherDescription(
            region: "\(model.location.name), \(model.location.country)",
            temperature: model.current.tempC,
            imageURL: model.current.condition.icon.toURLWithHTTPS(),
            currentWeather: model.current.condition.text,
            feelsAs: model.current.feelslikeC,
            windSpeed: windSpeed,
            humidity: model.current.humidity,
            pressure: model.current.pressureMB
        )
        
        DispatchQueue.main.async {
            self.viewController?.setWeatherDescriptionView(with: modelWeather)
        }
    }
    
    func setWeatherDescriptin(model: Weather) {
        for hour in model.forecast.forecastday[0].hour[0..<24] {
            let model = WeatherForecastHourly(
                date: hour.time.removeFirstCharacters(11),
                imageURL: hour.condition.icon.toURLWithHTTPS(),
                temperature: hour.tempC
            )
            forecastHourly.append(model)
        }
        
        DispatchQueue.main.async {
            self.viewController?.reloadCollectionViewData()
        }
    }
    
    func setTabelViewData(model: Weather) {
        for forecast in model.forecast.forecastday {
            let model = WeatherForecastDaily(
                date: Formatter.convertDateToCustomFormat(forecast.date),
                imageURL: forecast.day.condition.icon.toURLWithHTTPS(),
                dayTemperature: forecast.day.avgtempC,
                nightTemperature: forecast.day.avgtempC
            )
            forecastDaily.append(model)
        }
        
        DispatchQueue.main.async {
            self.viewController?.reloadTableViewData()
        }
    }
    
    func selectMainImage(model: Weather) {
        DispatchQueue.main.async {
            var mainImage = UIImageView()
            if model.current.isDay == 1 {
            mainImage = MainImageManager.selectImageDay(model: model)
            } else {
            mainImage = MainImageManager.selectImageNight(model: model)
            }
            self.viewController?.reloadViewMain(with: mainImage.image ?? UIImage())
        }
    }
    
    func sentCitys(with: [String]) {
        viewController?.sendListOfFoundCities(with: with)
    }
}
