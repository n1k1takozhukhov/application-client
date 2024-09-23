import UIKit
import Foundation

protocol LoginScreenCoordinatorProtocol {

}

final class LoginScreenCoordinator: Coordinator, LoginScreenCoordinatorProtocol {
    
    //MARK: Properties
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    //MARK: Init
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    //MARK: Methods
    
    func start() {
        let viewController = LoginViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: true)
        window?.rootViewController = navigationController
    }
}