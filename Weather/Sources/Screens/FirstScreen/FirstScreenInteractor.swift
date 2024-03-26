//
//  FirstScreenInteractor.swift
//  Weather
//
//  Created by Дрозд Денис on 22.03.2024.
//

import Foundation

// MARK: - Protocol

protocol FirstScreenInteractorProtocol: AnyObject {
    
}

final class FirstScreenInteractor: FirstScreenInteractorProtocol {
    
    // MARK: - Properties
    
    weak var presenter: FirstScreenPresenterProtocol?
}
