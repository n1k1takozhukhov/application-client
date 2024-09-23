//import Foundation
//
//protocol NetworkWorkerProtocol {
//    func performRequest<T: Codable>(queryParametres: [URLQueryItem]?,
//                                    endpoint: String,
//                                    apiMethod: APIMethods,
//                                    responseType: T.Type,
//                                    completionHandler: @escaping(Result<T, APIError>) -> Void)
//    
//}
//
//
//final class NetworkWorker: NetworkWorkerProtocol {
//    func performRequest<T>(queryParametres: [URLQueryItem]?, endpoint: String, apiMethod: APIMethods, responseType: T.Type, completionHandler: @escaping (Result<T, APIError>) -> Void) where T : Decodable, T : Encodable {
//        <#code#>
//    }
//    
//    
//}
