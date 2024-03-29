//
//  WeatherRouter.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import Foundation

// MARK: - Protocol

protocol WeatherRouterProtocol: AnyObject {
    var presenter: WeatherPresentationProtocol? { get }
}

final class WeatherRouter: WeatherRouterProtocol {
    weak var presenter: WeatherPresentationProtocol?
}
