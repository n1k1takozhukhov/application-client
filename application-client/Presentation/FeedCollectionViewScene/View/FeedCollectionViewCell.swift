import Foundation
import UIKit
import Resolver
import SDWebImage

protocol FeedCollectionViewCellDelegate: AnyObject {
    func imageDidTapped(authorName: String, description: String, image: UIImage)
}

final class FeedCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    static let reuseIdentifier = "feedCollectionViewCell"
    weak var delegate: FeedCollectionViewCellDelegate?
    private var viewModel: FeedCollectionViewCellViewModel?
    
    //MARK: UI Components
    
    private let containerView = makeContainerView()
    private let authorImage = makeAuthorImageView()
    private let authorNameLabel = makeTitleLabel()
    private let contentTextLabel = makeBodyLabel()
    private let dateTimeLabel = makeBodyLabel()
    private let postImageView = makeImageView()
    private lazy var likeButton = makeButton()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
        setupGestureRecognizer()
        setupLikeButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    func configure(with viewModel: FeedCollectionViewCellViewModel) {
        self.viewModel = viewModel
        
        if let url = viewModel.authorImageUrl {
            authorImage.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"))
        }
        authorNameLabel.text = viewModel.authorName
        contentTextLabel.text = viewModel.descriptionText
        dateTimeLabel.text = viewModel.formattedDate
        
        let likeImage = viewModel.likePost ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: likeImage), for: .normal)
        
        if let url = viewModel.postImageUrl {
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "noimage"))
        }
    }
    
    //MARK: Private Methods
    
    private func setupLikeButtonAction() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func likeButtonTapped() {
        guard let viewModel = viewModel else { return }
        viewModel.likePost.toggle()
        let likeImage = viewModel.likePost ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: likeImage), for: .normal)
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageDidTapped))
        postImageView.isUserInteractionEnabled = true
        postImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func imageDidTapped() {
        if let image = postImageView.image {
            delegate?.imageDidTapped(authorName: authorNameLabel.text ?? "nil", description: contentTextLabel.text ?? "nil", image: image)
        }
    }
}

//MARK: - Setup Constrain

private extension FeedCollectionViewCell {
    
    func setupConstrain() {
        setupAuthorImage()
        setupAuthorNameLabel()
        setupDateTimeLabel()
        setupLikePostView()
        setupBodyTextLabel()
        setupImage()
    }
    
    func setupAuthorImage() {
        contentView.addSubview(authorImage)
        
        NSLayoutConstraint.activate([
            authorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            authorImage.widthAnchor.constraint(equalToConstant: 48),
            authorImage.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupAuthorNameLabel() {
        contentView.addSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            authorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
        ])
    }
    
    func setupDateTimeLabel() {
        contentView.addSubview(dateTimeLabel)
        
        NSLayoutConstraint.activate([
            dateTimeLabel.topAnchor.constraint(equalTo: authorNameLabel.topAnchor, constant: 20),
            dateTimeLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
        ])
    }
    
    func setupLikePostView() {
        contentView.addSubview(likeButton)
        
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: authorImage.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupBodyTextLabel() {
        contentView.addSubview(contentTextLabel)
        
        NSLayoutConstraint.activate([
            contentTextLabel.topAnchor.constraint(equalTo: authorImage.bottomAnchor, constant: 10),
            contentTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setupImage() {
        contentView.addSubview(postImageView)
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: contentTextLabel.safeAreaLayoutGuide.bottomAnchor),
            postImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



//MARK: - Make UI

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
    
    static func makeImageView() -> UIImageView {
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
    
    func makeButton() -> UIButton {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "heart")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        return button
    }
}
