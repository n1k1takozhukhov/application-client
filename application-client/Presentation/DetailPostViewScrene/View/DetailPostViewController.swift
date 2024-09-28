import UIKit
import Resolver

final class DetailPostViewController: UIViewController {
    
    //MARK: Properties
    
    private let authorTitle = makeTitleLabel()
    private var authorNameLabel = makeTitleLabel()
    private let descriptionTitle = makeTitleLabel()
    private let descriptionTextLabel = makeBodyLabel()
    private let imageView = makeImage()
    
    //MARK: Init
    
    init(authorName: String, description: String, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.authorNameLabel.text = authorName
        self.descriptionTextLabel.text = description
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupConstrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Private Methods
    
    private func updateUI() {
        view.backgroundColor = .systemBackground
        authorTitle.text = "authorTitle:"
        descriptionTitle.text = "descriptionTitle:"
    }
}

//MARK: - Setup Constrain

private extension DetailPostViewController {
    
    func setupConstrain() {
        setupAuthorTitle()
        setupAuthorNameLabel()
        setupDescriptionTitle()
        setupDescriptionTextLabel()
        setupPostImageView()
    }
    
    func setupAuthorTitle() {
        view.addSubview(authorTitle)
        
        NSLayoutConstraint.activate([
            authorTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            authorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    func setupAuthorNameLabel() {
        view.addSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            authorNameLabel.centerYAnchor.constraint(equalTo: authorTitle.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorTitle.trailingAnchor, constant: 10),
        ])
    }
    
    func setupDescriptionTitle() {
        view.addSubview(descriptionTitle)
        
        NSLayoutConstraint.activate([
            descriptionTitle.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 20),
            descriptionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
    func setupDescriptionTextLabel() {
        view.addSubview(descriptionTextLabel)
        
        NSLayoutConstraint.activate([
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 10),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func setupPostImageView() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: descriptionTextLabel.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Make UI

private extension DetailPostViewController {
    
    static func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }
    
    static func makeBodyLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.textColor = .label
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }
    
    static func makeImage() -> UIImageView {
        let image = UIImage(named: "noimage")
        let item = UIImageView(image: image)
        item.contentMode = .scaleAspectFit
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }
}
