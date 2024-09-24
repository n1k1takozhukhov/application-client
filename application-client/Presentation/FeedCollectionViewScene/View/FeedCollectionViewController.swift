import Foundation
import UIKit
import Resolver

final class FeedCollectionViewController: UIViewController {
    
    //MARK: Properties
    
    var coordinator: FeedCollectionViewCoordinatorProtocol?
    @Injected var viewModel: FeedCollectionViewModelProtocol
    
    //MARK: UI Components

    private let collectionView = makeCollectionView()
    private let samoleText = makeLabel()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        title = "FeedCollectionViewController777"
        print("active")
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
        self.setupConstrain()

    }

    //MARK: Private Methods

    private func updateUI() {    }
    
    private func setupCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.reuseIdentifier, for: indexPath) as? FeedCollectionViewCell else { return UICollectionViewCell() }

        let article = self.viewModel.dataSource[indexPath.row]
        
        
        if let imageUrl = article.urlToImage {
            cell.configure(image: imageUrl)
        } else {
            cell.configure(image: "defaultImageUrl")
        }
        
        cell.delegate = self
        return cell
    }

}

//MARK: - UICollectionViewDelegate

extension FeedCollectionViewController: UICollectionViewDelegate { }


//MARK: - FeedCollectionViewCellDelegate

extension FeedCollectionViewController: FeedCollectionViewCellDelegate {
    func imageDidTapped(image: UIImage) {
        self.coordinator?.openPost(image: image)
    }
}



//MARK: - SetupConstrain

private extension FeedCollectionViewController {
    func setupConstrain() {
        setupCollectionViewConstrain()
        setupTextLabel()
    }
    
    func setupCollectionViewConstrain() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTextLabel() {
        view.addSubview(samoleText)
        
        NSLayoutConstraint.activate([
            samoleText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            samoleText.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


//MARK: - makeCollectionView
    
private extension FeedCollectionViewController {
    static func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        let inset: CGFloat = 16
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 14
        flowLayout.sectionInset = UIEdgeInsets(top: 0,
                                               left: inset * 2,
                                               bottom: 0,
                                               right: inset * 2)
        let item = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        item.showsHorizontalScrollIndicator = false
        return item
    }
    
    static func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ASDASDSA"
        view.font = .systemFont(ofSize: 40)
        return view
    }
}

