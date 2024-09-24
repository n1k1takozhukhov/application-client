import Foundation
import Resolver

protocol APIRepositoryProtocol {
    func getAllNews(completionHandler: @escaping (Result<NewsResponse, APIError>) -> Void)
}


final class APIRepository: APIRepositoryProtocol {
    
    //MARK: Properties
    @Injected var apiService: APIServiceProtocol
    
    //MARK: Methods
    
    func getAllNews(completionHandler: @escaping (Result<NewsResponse, APIError>) -> Void) {
        apiService.getNews { result in
            completionHandler(result)
        }
    }
}
