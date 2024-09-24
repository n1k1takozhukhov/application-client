import Foundation

struct AppClientModel: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let id: Int
    let text: String
    let date: String
    let author: Author
    let images: [String] // Список URL изображений
    let likes: Int
}

struct Author: Codable {
    let id: Int
    let name: String
    let avatarUrl: String
}
