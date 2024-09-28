import Foundation
import Resolver

protocol FeedCollectionViewModelProtocol {
    var dataSource: [Article] { get set }
    func fetchData(completionHandler: @escaping () -> Void)
}

final class FeedCollectionViewModel: FeedCollectionViewModelProtocol {
    
    //MARK: Properties
    
    @Injected var apiRepository: APIRepository
    var dataSource: [Article] = []
    
    //MARK: Methods
    
    func fetchData(completionHandler: @escaping () -> Void) {
        apiRepository.getAllNews { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.dataSource = response.articles 
                completionHandler()
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler()
            }
        }
    }
}
