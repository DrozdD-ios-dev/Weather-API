//
//  WeatherAssembly.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

final class WeatherAssembly {
    
    static func configure() -> MainScreenViewContriller {
        let interactor = WeatherInteractor()
        let router = WeatherRouter()
        
        let presenter = WeatherPresenter(interactor: interactor, router: router)
        interactor.presenter = presenter
        router.presenter = presenter
        
        let viewController = MainScreenViewContriller(presenter: presenter)
        presenter.viewController = viewController
        
        return viewController
    }
}
