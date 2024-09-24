import Foundation
import Resolver

protocol APIServiceProtocol {
    func getAllNews(completionHandler: @escaping (Result<AppClientModel, APIError>) -> Void)
}

struct APIService: APIServiceProtocol {
    
    //MARK: Properties
    @Injected var worker: NetworkWorkerProtocol
    
    //MARK: Methods
    
    func getAllNews(completionHandler: @escaping (Result<AppClientModel, APIError>) -> Void) {
        worker.performRequest(
            queryParametres: nil,
            endpoint: EndPoint.mainScreen.rawValue,
            apiMethod: .get,
            responseType: AppClientModel.self,
            completionHandler: completionHandler)
    }
}
