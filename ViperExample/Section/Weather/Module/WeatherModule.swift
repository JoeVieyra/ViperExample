//
//  WeatherModule.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import Foundation
import UIKit

final class WeatherModule {
    private let presenter: WeatherPresenterProtocol
    
    init(baseViewController: UIViewController) {
        let interactor = WeatherInteractor(dataManager: WeatherDataManager())
        let router = WeatherRouter(baseViewController: baseViewController)
        presenter = WeatherPresenter(interactor: interactor, router: router)
    }
    
    init(window: UIWindow) {
        let interactor = WeatherInteractor(dataManager: WeatherDataManager())
        let router = WeatherRouter(window: window)
        presenter = WeatherPresenter(interactor: interactor, router: router)
    }
    
    func showScreen() {
        return presenter.showScreen()
    }
}
