import Foundation
import Resolver

protocol APIRepositoryProtocol {
    func getAllNews(completionHandler: @escaping (Result<AppClientModel, APIError>) -> Void)
}


final class APIRepository: APIRepositoryProtocol {
    
    //MARK: Properties
    @Injected var apiService: APIServiceProtocol
    
    //MARK: Methods

    func getAllNews(completionHandler: @escaping (Result<AppClientModel, APIError>) -> Void) {
        apiService.getAllNews { result in
            completionHandler(result)
        }
    }
}
