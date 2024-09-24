import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController? { get set }
    var window: UIWindow? { get set }
    
    func start()
}
