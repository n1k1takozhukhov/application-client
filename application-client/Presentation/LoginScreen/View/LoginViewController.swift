import UIKit
import Resolver

final class LoginViewController: UIViewController {
    var coordinator: LoginScreenCoordinatorProtocol?
    @Injected var viewModel: LoginViewModelProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        
    }
}

