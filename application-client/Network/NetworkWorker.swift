import Foundation

protocol NetworkWorkerProtocol {
    
    func performRequest<T: Codable>(queryParametres: [URLQueryItem]?,
                                    endpoint: String,
                                    apiMethod: APIMethods,
                                    responseType: T.Type,
                                    completionHandler: @escaping(Result<T, APIError>) -> Void)
}

class NetworkWorker: NetworkWorkerProtocol {
    
    // MARK: - Properties
    
    let decoder = JSONDecoder()
    let scheme: String = "https"
    let host: String = "newsapi.org"
    
    // MARK: - Methods
    
    func performRequest<T: Codable>(queryParametres: [URLQueryItem]?,
                                    endpoint: String,
                                    apiMethod: APIMethods,
                                    responseType: T.Type,
                                    completionHandler: @escaping(Result<T, APIError>) -> Void) {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = endpoint

        guard var url = components.url else {
            completionHandler(Result.failure(APIError.badURL))
            return
        }
            
        if let queryParametres = queryParametres {
            url.append(queryItems: queryParametres)
        }
            
        let headers = [
            "accept": "application/json",
        ]
        
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
