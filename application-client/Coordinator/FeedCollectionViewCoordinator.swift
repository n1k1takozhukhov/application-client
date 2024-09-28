import Foundation
import UIKit


protocol FeedCollectionViewCoordinatorProtocol {
    func openPost(authorName: String, description: String, image: UIImage)
}


final class FeedCollectionViewCoordinator: Coordinator, FeedCollectionViewCoordinatorProtocol {
    
    //MARK: Properties

    var navigationController: UINavigationController?
    var window: UIWindow?
    
    //MARK: Init
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: Methods
    
    func start() {
        let viewController = FeedCollectionViewController()
        viewController.coordinator = self
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func openPost(authorName: String, description: String, image: UIImage) {
        let viewController = DetailPostViewController(authorName: authorName, description: description, image: image)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
