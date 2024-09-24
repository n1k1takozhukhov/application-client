import Foundation

protocol NetworkWorkerProtocol {
    func performRequest<T: Codable>(queryParametres: [URLQueryItem]?,
                                    endpoint: String,
                                    apiMethod: APIMethods,
                                    responseType: T.Type,
                                    completionHandler: @escaping(Result<T, APIError>) -> Void)
}

final class NetworkWorker: NetworkWorkerProtocol {
    
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    
    // MARK: - Methods
    
    func performRequest<T: Codable>(queryParametres: [URLQueryItem]?,
                                    endpoint: String,
                                    apiMethod: APIMethods,
                                    responseType: T.Type,
                                    completionHandler: @escaping(Result<T, APIError>) -> Void) {
        
        var components = URLComponents()
        components.scheme = APIConfig.scheme
        components.host = APIConfig.host
        components.path = endpoint
        
        // Добавляем apiKey в запрос как параметр
        var fullQueryItems = queryParametres ?? []
        let apiKeyItem = URLQueryItem(name: "apiKey", value: APIConfig.apiKey)
        fullQueryItems.append(apiKeyItem)
        components.queryItems = fullQueryItems
        
        guard let url = components.url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
        
        let headers = ["accept": "application/json"]
        
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = apiMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as? URLError {
                completionHandler(Result.failure(APIError.url(error)))
            } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completionHandler(Result.failure(APIError.badResponse(statusCode: httpResponse.statusCode)))
            } else if let data = data {
                self.decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try self.decoder.decode(responseType.self, from: data)
                    completionHandler(Result.success(response))
                } catch {
                    completionHandler(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
