//
//  WeatherInteractor.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import Foundation

protocol WeatherInteractorProtocol {
    
}

class WeatherInteractor {
    private let dataManager: WeatherDataManagerProtocol
    
    init(dataManager: WeatherDataManagerProtocol) {
        self.dataManager = dataManager
    }
}

extension WeatherInteractor: WeatherInteractorProtocol {
}

