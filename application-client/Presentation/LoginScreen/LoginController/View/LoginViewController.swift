import UIKit
import Resolver

final class LoginViewController: UIViewController {
    
    // MARK: Properties

    var coordinator: LoginScreenCoordinatorProtocol?
    @Injected var viewModel: LoginViewModelProtocol

    
    //MARK: UI Components

    private let titleLabel = makeTitleLabel()
    private let titleImageView = makeImageView()
    private lazy var loginTextField = makeTextField()
    private lazy var passwordTextField = makeTextField()
    private lazy var autButton = makeAutButton()
    private let titleCreateAcc = makeBodyLabel()
    private lazy var createAccountButton = makeCreateAccountButton()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupConstrain()
        
    }
    
    // MARK: Private methods
    private func updateUI() {
        view.backgroundColor = .systemBackground

        titleLabel.text = "Sing in"
        titleImageView.image = UIImage(named: "noimage")
        
        loginTextField.placeholder = " Enter your login"
        passwordTextField.placeholder = " Enter your password"

        autButton.setTitle("Login Account", for: .normal)
        autButton.addAction(UIAction { [weak self] _ in
//            self?.viewModel.didTapLoginButton()
            self?.coordinator?.navigateToFeed()
        }, for: .touchUpInside)
        
        titleCreateAcc.text = "do you not have account? "
        
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.addAction(UIAction { [weak self] _ in
//            self?.viewModel.didTapCreateAccountButton()
            self?.coordinator?.navigateToFeed()

        }, for: .touchUpInside)
    }
}


//MARK: - Setup Constrain

private extension LoginViewController {
    func setupConstrain() {
        setupTitleImageView()
        setupTitleLabel()
        setupLoginTextField()
        setupPasswordTextField()
        setupAutButton()
        setupCreateAccountTitle()
        setupCreateAccountButton()
    }
    
    func setupTitleImageView() {
        view.addSubview(titleImageView)
        
        NSLayoutConstraint.activate([
            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleImageView.widthAnchor.constraint(equalToConstant: 60),
            titleImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupLoginTextField() {
        view.addSubview(loginTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupAutButton() {
        view.addSubview(autButton)
        
        NSLayoutConstraint.activate([
            autButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            autButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
    
    func setupCreateAccountTitle() {
        view.addSubview(titleCreateAcc)
        
        NSLayoutConstraint.activate([
            titleCreateAcc.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            titleCreateAcc.leadingAnchor.constraint(equalTo: autButton.leadingAnchor)
        ])
    }
    
    func setupCreateAccountButton() {
        view.addSubview(createAccountButton)
        
        NSLayoutConstraint.activate([
            createAccountButton.centerYAnchor.constraint(equalTo: titleCreateAcc.centerYAnchor),
            createAccountButton.leadingAnchor.constraint(equalTo: titleCreateAcc.trailingAnchor, constant: 5)
        ])
    }
}

//MARK: - Make UI

private extension LoginViewController {
    static func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 32)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }
    
    static func makeBodyLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 12)
        view.textColor = .gray
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }
    
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }
    
    func makeTextField() -> UITextField {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }
    
    func makeAutButton() -> UIButton {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 350).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        view.setTitleColor(.tintColor, for: .normal)
        return view
    }
    
    static func makeUIView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray3
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }
    
    func makeCreateAccountButton() -> UIButton {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }
}
