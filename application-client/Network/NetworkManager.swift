import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(NetworkError.noInternetConnection))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidResponse
}
