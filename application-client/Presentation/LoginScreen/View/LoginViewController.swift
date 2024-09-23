import UIKit
import Resolver

final class LoginViewController: UIViewController {
    var coordinator: LoginScreenCoordinatorProtocol?
    @Injected var viewModel: LoginViewModelProtocol

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad called") // Для проверки
        view.backgroundColor = .red
    }
}

