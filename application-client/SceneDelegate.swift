import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        Resolver.registerAllServices()
        
        let navVC = UINavigationController()
        appCoordinator = AppCoordinator(navVC)
        appCoordinator?.window = window
        appCoordinator?.start()
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
}
