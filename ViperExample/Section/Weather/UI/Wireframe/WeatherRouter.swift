//
//  WeatherRouter.swift
//  ViperExample
//
//  Created by Mariana Ramos on 28/09/22.
//  

import Foundation
import UIKit

protocol WeatherRouterProtocol {
    func showScreen(presenter: WeatherPresenterProtocol)
}

class WeatherRouter {
    private weak var baseController: UIViewController?
    private weak var module: WeatherViewController?
    private weak var window: UIWindow?
    
    init(baseViewController: UIViewController) {
        baseController = baseViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private func changeRootViewControllerToLaunchScreen(presenter: WeatherPresenterProtocol) {
        let viewController = WeatherViewController(presenter: presenter)
        let navigation = UINavigationController(rootViewController: viewController)
        baseController = navigation
        changeRootViewControllerWith(controller: navigation)
    }
    
    private func showScreenFromWindow(presenter: WeatherPresenterProtocol) {
        guard let win = window else {
            changeRootViewControllerToLaunchScreen(presenter: presenter)
            return
        }
        let viewController = WeatherViewController(presenter: presenter)
        let navigation = UINavigationController(rootViewController: viewController)
        baseController = navigation
        win.rootViewController = navigation
    }
    
    func changeRootViewControllerWith(controller: UIViewController, completion: ((Bool) -> Void)? = nil) {
        UIApplication.shared.keyWindow?.rootViewController = controller
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: completion)

    }
}

extension WeatherRouter: WeatherRouterProtocol {
    func showScreen(presenter: WeatherPresenterProtocol) {
        guard let controller = baseController as? UINavigationController else {
            showScreenFromWindow(presenter: presenter)
            return
        }
        
        let viewController = WeatherViewController(presenter: presenter)
        controller.pushViewController(viewController, animated: true)
    }
}
