//
//  WeatherInteractor.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

// MARK: - Protocol

protocol WeatherInteractorProtocol: AnyObject {
    func fetchData(parameter: String, completion: @escaping (Result<Weather, NetworkError>) -> Void)
    func getData(parameter: String)
    func searchCity(with: String)
}
// MARK: - Enum NetworkError

enum NetworkError: Error {
    case requestFailed
    case invalidResponse
}

final class WeatherInteractor: WeatherInteractorProtocol {
    
    // MARK: - Properties
    
    weak var presenter: WeatherPresentationProtocol?
    
    // MARK: - Public functions
    
    func getData(parameter: String) {
        fetchData(parameter: parameter) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weather):
                presenter?.downloadData(weather: weather)
                
            case .failure(let error):
                presenter?.passError(code: "404")
                print("Failure! Error: \(error)")
            }
        }
    }
    
    // Метод отправляющий запрос по конкретному городу
    func fetchData(parameter: String, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=2b2a831937964f21bf464404241603&q=\(parameter)&days=7&aqi=no&alerts=no") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch {
                self.presenter?.passError(code: "ErrorDecode")
                print("Ошибка декодирования: \(error)")
            }
        }
        task.resume()
    }
    
    // Метод отправляющий запрос по одной букве для поиска города
    func searchCity(with: String) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/search.json?key=2b2a831937964f21bf464404241603&q=\(with)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error get City")
                return
            }
            
            guard let data else {
                print("Error get City")
                return
            }
            
            do {
                let city = try JSONDecoder().decode([SearchCity].self, from: data)
                self.presenter?.sentCitys(with: (city.map { $0.name }))
            } catch {
                print("Ошибка декодирrования: \(error)")
            }
        }
        task.resume()
    }
}
