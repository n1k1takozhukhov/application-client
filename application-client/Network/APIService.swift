import Foundation
import Resolver

protocol APIServiceProtocol {
    func getNews(completionHandler: @escaping (Result<NewsResponse, APIError>) -> Void)
}

struct APIService: APIServiceProtocol {
    
    // MARK: - Properties
    
    @Injected var worker: NetworkWorkerProtocol
    
    // MARK: - Methods
    
    func getNews(completionHandler: @escaping (Result<NewsResponse, APIError>) -> Void) {
        let queryParameters = [
            URLQueryItem(name: "q", value: "tesla"),
            URLQueryItem(name: "from", value: "2024-08-24"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name: "apiKey", value: "a7f01d2cbbbc4f458701322c1331e86a")
        ]
        
        worker.performRequest(
            queryParametres: queryParameters,
            endpoint: Endpoints.everything.rawValue,
            apiMethod: .get,
            responseType: NewsResponse.self,
            completionHandler: completionHandler
        )
    }
}
