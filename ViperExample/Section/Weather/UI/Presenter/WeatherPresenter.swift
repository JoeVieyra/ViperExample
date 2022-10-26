//
//  WeatherPresenter.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import Foundation
import UIKit

protocol WeatherPresenterProtocol {
    func showScreen()
    func setViewProtocol(view: WeatherViewControllerProtocol)
}

class WeatherPresenter {
    private weak var viewProtocol: WeatherViewControllerProtocol?
    private let interactor: WeatherInteractorProtocol
    private let router: WeatherRouterProtocol
    
    init(interactor: WeatherInteractorProtocol, router: WeatherRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension WeatherPresenter: WeatherPresenterProtocol {
    func showScreen() {
        return router.showScreen(presenter: self)
    }
    
    func setViewProtocol(view: WeatherViewControllerProtocol) {
        viewProtocol = view
    }
}
