//
//  AppDelegate.swift
//  Amadeus
//
//  Created by Mehran Kamalifard on 5/30/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootViewController()
        
        /// implement app dependency with Command Design Pattern
        StartCommonBuilder()
            .build()
            .forEach({ $0.execute() })
        
        return true
    }

    func setRootViewController() {
        
        let navigationController: UINavigationController = .init()
        self.appCoordinator = AppCoordinator.init(navigationController)
        
        self.appCoordinator?.start()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

