import Foundation
import UIKit

final class FeedCollectionViewCellViewModel {
    
    //MARK: Properties

    private let article: Article
        
    //MARK: Init

    init(article: Article) {
        self.article = article
    }
    
    //MARK: Methods
    
    var authorImageUrl: URL? {
        return URL(string: article.urlToImage ?? "")
    }
    
    var authorName: String {
        return article.author ?? "Unknown Author"
    }
    
    var descriptionText: String {
        return article.description ?? "No description available"
    }
    
    var formattedDate: String {
        return formatDate(article.publishedAt)
    }
    
    var postImageUrl: URL? {
        return URL(string: article.urlToImage ?? "")
    }
    
    var likePost: Bool = false
    
    //MARK: Private Methods
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
