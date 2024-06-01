//
//  ArticleAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI
import Combine

class ArticleAPIServices {
    @Published var thumbnail: Image?
    
    private let domain: NetworkLayer
    
    private var imageTask: Task<Void, Error>?
    
    init(domain: NetworkLayer = APIServices.shared, article: Article) {
        self.domain = domain
        self.imageTask?.cancel()
        self.imageTask = Task {
            if let thumbnail = try await self.domain.downloadImage(url: article.thumbnailURL) {
                await MainActor.run { self.thumbnail = thumbnail }
            }
        }
    }
}

// MARK: - REST
extension ArticleAPIServices {
    func updateCountOfViews(articleMetadataId: Int) async throws {
        let url = "http://\(GlobalAssets.serverIP)/sections/update-article-views/"
        let parameters: [String : Any] = ["id" : articleMetadataId]
        let _: ArticleMetadata = try await domain.put(url: url, parameters: parameters)
    }
    
    func insertArticleToViewedArticles(of currentUserId: Int, with currentArticleId: Int) async throws {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/viewed-articles-related/"
        let parameters: [String : Any] = ["current_user_id" : currentUserId, "current_article_id" : currentArticleId]
        let user: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
        print(user.beatitudoMediaUser)
    }
}
