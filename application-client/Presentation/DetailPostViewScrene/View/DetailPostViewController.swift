import UIKit
import Resolver

final class DetailPostViewController: UIViewController {
    
    //MARK: Properties
    private let image = makeImage()
    
    //MARK: Init
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setupConstrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUI()
        self.setupConstrain()

    }

    //MARK: Private Methods

    private func updateUI() {
        view.backgroundColor = .purple
    }
}



//MARK: SetupConstrain

private extension DetailPostViewController {
    func setupConstrain() {
        setupImage()
    }
    
    func setupImage() {
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 250),
            image.widthAnchor.constraint(equalToConstant: 250),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}


//MARK: MakeUI

private extension DetailPostViewController {
    static func makeImage() -> UIImageView {
        let image = UIImage(named: "noimage")
        let item = UIImageView(image: image)
        item.contentMode = .scaleAspectFit
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }
}
