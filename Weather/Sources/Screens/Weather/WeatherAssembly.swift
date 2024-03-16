//
//  WeatherAssembly.swift
//  Weather
//
//  Created by Дрозд Денис on 25.02.2024.
//

import UIKit

final class WeatherAssembly {
//    func configurate(_ vc: VcOneDisplayLogic) {  // две реализации - смысл один 
//        let presenter = VcOnePresenter()
//        let router = VcOneRouter()
//        let interactor = VcOneInteractor()
//        vc.presenter = presenter
//        presenter.viewController = vc
//        presenter.router = router
//        router.presenter = presenter
//        presenter.interactor = interactor
//        interactor.presenter = presenter
//    }
    
//    static func configurate(regRef: VcOneViewController) {
//        let presenter: VcOnePresentationProtocol = VcOnePresenter()
//        regRef.presenter = presenter
//        regRef.presenter?.router = VcOneRouter()
//        regRef.presenter?.viewController = regRef
//        regRef.presenter?.interactor = VcOneInteractor()
//        regRef.presenter?.interactor?.presenter = presenter
//    }
    
    static func configure() -> WeatherVC {
        let interactor = WeatherInteractor()
        let router = WeatherRouter()
        
        let presenter = WeatherPresenter(interactor: interactor, router: router)
        interactor.presenter = presenter
        router.presenter = presenter
        
        let viewController = WeatherVC(presenter: presenter)
        presenter.viewController = viewController
        
        return viewController
    }
}
