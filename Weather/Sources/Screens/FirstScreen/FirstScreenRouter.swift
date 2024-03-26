//
//  FirstScreenRouter.swift
//  Weather
//
//  Created by Дрозд Денис on 22.03.2024.
//

import UIKit

// MARK: - Protocol

protocol FirstScreenRouterProtocol: AnyObject {
    var presenter: FirstScreenPresenterProtocol? { get }
    func nextScreen()
}

final class FirstScreenRouter: FirstScreenRouterProtocol {
    
    // MARK: - Properties
    
  weak  var presenter: FirstScreenPresenterProtocol?
    
    // MARK: - Public functions
    
    func nextScreen() {
        let viewC = WeatherAssembly.configure()
        presenter?.viewController?.navigationController?.pushViewController(viewC, animated: true)
    }
}
