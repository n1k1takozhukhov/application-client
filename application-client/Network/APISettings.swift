import Foundation

enum APIMethods: String {
    case get = "GET"
}

enum Endpoints: String {
    case everything = "/v2/everything"
}

enum APIError: Error, LocalizedError {
    case badURL
    case badResponse(statusCode: Int)
    case emptyResponse
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
        
    var errorDescription: String? {
        
        switch self {
        case .badURL:
            return "Invalid url. Check credentials."
        case .parsing:
            return "Parsing error. Check Models."
        case .unknown:
            return "Unknown error."
        case .badResponse(let statusCode):
            return "Bad Response. Status code: \(statusCode)"
        case .emptyResponse:
            return "Empty response."
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        }
    }
}
