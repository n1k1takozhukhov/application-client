//
//  AppDelegate.swift
//  application-client
//
//  Created by Никита Кожухов on 23.09.2024.
//

import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        Resolver.registerAllServices()
        let navVC = UINavigationController()
        appCoordinator = AppCoordinator(navVC)
        window?.backgroundColor = .blue // Добавь, чтобы проверить отображение
        appCoordinator?.window = window
        appCoordinator?.start()
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
