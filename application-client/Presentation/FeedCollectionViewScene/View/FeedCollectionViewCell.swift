import Foundation
import UIKit
import Resolver
import SDWebImage

protocol FeedCollectionViewCellDelegate: AnyObject {
    func imageDidTapped(image: UIImage)
}

final class FeedCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    static let reuseIdentifier = "feedCollectionViewCell"
    weak var delegate: FeedCollectionViewCellDelegate?
    
    //MARK: UI Components
    private let containerView = makeContainerView()
    private let authorImage = makeAuthorImageView()
    private let authorNameLabel = makeTitleLabel()
    private let contentTextLabel = makeBodyLabel()
    private let dateTimeLabel = makeBodyLabel()
    private let postImageView = makePostImageView()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
        updateUI()
        setupGestureRecognizer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:  Methods
    
    func configure(with article: Article) {
        if let authorImageUrl = article.urlToImage, let url = URL(string: authorImageUrl) {
            authorImage.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"))
        }
        authorNameLabel.text = article.author ?? "Unknown Author"
        contentTextLabel.text = article.description ?? "No description available"
        dateTimeLabel.text = formatDate(article.publishedAt)
        
        if let postImageUrl = article.urlToImage, let url = URL(string: postImageUrl) {
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"))
        }
    }
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    
    //MARK: Private Methods
    
    private func updateUI() { }
        
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTapped))
        postImageView.isUserInteractionEnabled = true
        postImageView.addGestureRecognizer(tapGesture)
    }

    @objc
    private func imageDidTapped() {
        print("qwe")
        if let image = postImageView.image {
            delegate?.imageDidTapped(image: image)
        }
    }
}

//MARK: SetupConstrain

private extension FeedCollectionViewCell {
    func setupConstrain() {
        setupContainerView()
        setupAuthorImage()
        setupAuthorNameLabel()
        setupDateTimeLabel()
        setupBodyTextLabel()
        setupImage()
    }
    
    func setupContainerView() {
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupAuthorImage() {
        containerView.addSubview(authorImage)
        
        NSLayoutConstraint.activate([
            authorImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            authorImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            authorImage.widthAnchor.constraint(equalToConstant: 48),
            authorImage.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupAuthorNameLabel() {
        containerView.addSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
        ])
    }
    
    func setupDateTimeLabel() {
        containerView.addSubview(dateTimeLabel)
        
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: authorNameLabel.topAnchor, constant: 20),
            dateTimeLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
        ])
    }
    
    func setupBodyTextLabel() {
        containerView.addSubview(contentTextLabel)
        
        NSLayoutConstraint.activate([
            contentTextLabel.topAnchor.constraint(equalTo: authorImage.bottomAnchor, constant: 10),
            contentTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            contentTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    func setupImage() {
        containerView.addSubview(postImageView)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentTextLabel.safeAreaLayoutGuide.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



//MARK: MakeUI

private extension FeedCollectionViewCell {
    static func makeAuthorImageView() -> UIImageView {
        let image = UIImage(named: "noimage")
        let item = UIImageView(image: image)
        item.translatesAutoresizingMaskIntoConstraints = false
        item.contentMode = .scaleAspectFill
        item.clipsToBounds = true
        item.heightAnchor.constraint(equalToConstant: 48).isActive = true
        item.widthAnchor.constraint(equalToConstant: 48).isActive = true
        item.layer.cornerRadius = 24
        item.layer.masksToBounds = true
        return item
    }
    
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
        view.numberOfLines = 3
        view.textAlignment = .left
        return view
    }
    
    static func makePostImageView() -> UIImageView {
        let image = UIImage(named: "noimage")
        let item = UIImageView(image: image)
        item.translatesAutoresizingMaskIntoConstraints = false
        item.contentMode = .scaleAspectFit
        return item
    }
    
    static func makeContainerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 15
        return view
    }
}
