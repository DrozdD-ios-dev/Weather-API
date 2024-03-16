//
//  WeatherInteractor.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

protocol WeatherInteractorProtocol: AnyObject {
    func fetchData(parameter: String, completion: @escaping (Result<Weather, NetworkError>) -> Void)
    func getData(parameter: String)
    func searchCity(with: String)
}

enum NetworkError: Error {
    case requestFailed
    case invalidResponse
}

final class WeatherInteractor: WeatherInteractorProtocol {
    
    weak var presenter: WeatherPresentationProtocol?

    func getData(parameter: String) {
        fetchData(parameter: parameter) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weather):
                presenter?.downloadData(weather: weather)
                
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    func fetchData(parameter: String, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=7891af3d376b447a895105303242702&q=\(parameter)&days=7&aqi=no&alerts=no") else { return }
        
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
            
//            let checkDataUtf8 = String(data: data, encoding: .utf8) // проверка кодировки
//            print("checkDataUtf8 \(checkDataUtf8!)")
            
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
//                print(weather)
            } catch {
                print("Ошибка декодирования: \(error)")
            }
        }
        
        task.resume()
    }
    
    func searchCity(with: String) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/search.json?key=7891af3d376b447a895105303242702&q=\(with)") else { return }
        
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
                print("Ошибка декодирования: \(error)")
            }
            
        }
        task.resume()
    }
}
