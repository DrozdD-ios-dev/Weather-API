//
//  FirstScreenAssembly.swift
//  Weather
//
//  Created by Дрозд Денис on 22.03.2024.
//

import UIKit

final class FirstScreenAssembly {
    
    static func configure() -> FirstScreenViewController {
        let interactor = FirstScreenInteractor()
        let router = FirstScreenRouter()
        
        let presenter = FirstScreenPresenter(interactor: interactor, router: router)
        interactor.presenter = presenter
        router.presenter = presenter
        
        let viewController = FirstScreenViewController(presenter: presenter)
        presenter.viewController = viewController
        
        return viewController
    }
}
