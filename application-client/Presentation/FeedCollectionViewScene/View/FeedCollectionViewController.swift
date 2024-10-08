import Foundation
import UIKit
import Resolver

final class FeedCollectionViewController: UIViewController {
    
    //MARK: Properties
    
    var coordinator: FeedCollectionViewCoordinatorProtocol?
    @Injected var viewModel: FeedCollectionViewModelProtocol
    private var isPostOpening = false
    
    //MARK: UI Components
    
    private lazy var collectionView = makeCollectionView()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.updateUI()
        self.setupConstrain()
    }
    
    //MARK: Private Methods
    
    private func updateUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                if NetworkMonitor.shared.isConnected {
                    self.collectionView.reloadData()
                } else {
                    self.showAlert(message: "There is no internet connection.")
                }
            }
        }
    }
    
    private func setupCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource

extension FeedCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier, for: indexPath) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let article = self.viewModel.dataSource[indexPath.row]
        let cellViewModel = FeedCollectionViewCellViewModel(article: article)
        cell.configure(with: cellViewModel)
        cell.delegate = self
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension FeedCollectionViewController: UICollectionViewDelegate { }


//MARK: - FeedCollectionViewCellDelegate

extension FeedCollectionViewController: FeedCollectionViewCellDelegate {
    func imageDidTapped(authorName: String, description: String, image: UIImage) {
        guard !isPostOpening else { return }
        isPostOpening = true
        
        self.coordinator?.openPost(authorName: authorName, description: description, image: image)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isPostOpening = false
        }
    }
}



//MARK: - SetupConstrain

private extension FeedCollectionViewController {
    func setupConstrain() {
        setupCollectionViewConstrain()
    }
    
    func setupCollectionViewConstrain() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: - makeCollectionView

private extension FeedCollectionViewController {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        return UICollectionView(
            frame: .zero, collectionViewLayout: layout)
    }
}
