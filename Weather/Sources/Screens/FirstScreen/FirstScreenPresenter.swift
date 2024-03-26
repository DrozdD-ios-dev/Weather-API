//
//  FirstScreenPresenter.swift
//  Weather
//
//  Created by Дрозд Денис on 22.03.2024.
//

import Foundation

// MARK: - Protocol

protocol FirstScreenPresenterProtocol: AnyObject {
    var viewController: FirstScreenViewController? { get }
    func pushVC()
}

final class FirstScreenPresenter: FirstScreenPresenterProtocol {
    
    // MARK: - Properties
    
    weak var viewController: FirstScreenViewController?
    let interactor: FirstScreenInteractorProtocol
    let router: FirstScreenRouterProtocol
    
    // MARK: - Init
    
    init(interactor: FirstScreenInteractorProtocol, router: FirstScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Public function
    
    func pushVC() {
        router.nextScreen()
    }
}
