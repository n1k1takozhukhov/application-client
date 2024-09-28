import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    
}


final class AppCoordinator: Coordinator, AppCoordinatorProtocol {
    
    //MARK: Properties
    
    var navigationController: UINavigationController?
    var window: UIWindow?
    
    //MARK: Init
    
    required init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Methods
    
    func start() {
        let coordinator = LoginScreenCoordinator(navigationController)
        coordinator.window = window
        coordinator.start()
    }
}
