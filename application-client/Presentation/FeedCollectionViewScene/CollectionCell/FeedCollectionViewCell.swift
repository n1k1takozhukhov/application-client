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
    
    private let container = makeUIView()
    private let image = makeImage()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:  Methods
    
    func configure(image: String) {
        if image != "" {
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageDidTapped))
            contentView.addGestureRecognizer(tap)
        }
        self.image.sd_setImage(
            with: URL(string: image),
            placeholderImage: UIImage(named: "noimage")
        )
    }
    
    //MARK: Private Methods
    
    private func updateUI() { }
    
    @objc
    private func imageDidTapped() {
        if let image = self.image.image {
            delegate?.imageDidTapped(image: image)
        }
    }
}

//MARK: SetupConstrain

private extension FeedCollectionViewCell {
    func setupConstrain() {
        setupImage()
    }
    
    func setupImage() {
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 250),
            image.widthAnchor.constraint(equalToConstant: 250),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}


//MARK: MakeUI

private extension FeedCollectionViewCell {
    static func makeUIView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeImage() -> UIImageView {
        let image = UIImage(named: "")
        let item = UIImageView(image: image)
        item.translatesAutoresizingMaskIntoConstraints = false
        item.contentMode = .scaleAspectFit
        return item
    }
}
