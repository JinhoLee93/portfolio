//
//  UserArticlesAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import Foundation

class UserArticlesAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var articles: [Article]?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
}

// MARK: - API
extension UserArticlesAPIServices {
    func translateUserArticlesIntoArticles(isForViewedArticles: Bool) async throws {
        let url = "http://\(GlobalAssets.serverIp)/sections/translate_user_articles_into_articles/"
        let article_ids: [Int] = isForViewedArticles ? GlobalAssets.currentUser?.viewedArticles.map { $0.articleId } ?? [] : GlobalAssets.currentUser?.lovedArticles.map { $0.articleId } ?? []
        let parameters = ["article_ids" : article_ids]
        let fetchedArticles: Articles = try await domain.post(url: url, parameters: parameters)
        await MainActor.run { articles = fetchedArticles.articles }
    }
}
