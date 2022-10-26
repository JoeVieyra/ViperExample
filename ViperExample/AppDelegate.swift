//
//  AppDelegate.swift
//  ViperExample
//
//  Created by Mariana Ramos on 27/09/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        self.installRootViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func installRootViewController() {
        guard let window = window else { return }
        let launch = WeatherModule(window: window)
        launch.showScreen()
    }
    
}

