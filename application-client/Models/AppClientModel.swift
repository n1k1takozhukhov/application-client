import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String
    let description: String?
    let urlToImage: String?
    let publishedAt: String
}
