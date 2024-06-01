//
//  ArticleViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ArticleViewModel: ObservableObject {
    private let article: Article
    @Published var thumbnail: Image?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let domain: ArticleAPIServices
    
    init(domain: NetworkLayer = APIServices.shared, article: Article) {
        self.article = article
        self.domain = ArticleAPIServices(article: article)
        self.addSubscribers()
    }
}

// MARK: - API
extension ArticleViewModel {
    func updateCountOfViews() async throws {
        try await domain.updateCountOfViews(articleMetadataId: article.articleMetadata.id)
    }
    
    func insertArticleToViewedArticles() async throws {
        guard let currentUserId = GlobalAssets.currentUserID else { return }
        try await domain.insertArticleToViewedArticles(of: currentUserId, with: article.id)
    }
}

// MARK: - Combine
extension ArticleViewModel {
    private func addSubscribers() {
        self.domain.$thumbnail
            .sink { [weak self] in
                if let thumbnail = $0 {
                    self?.thumbnail = thumbnail
                }
            }
            .store(in: &anyCancellables)
    }
}

// MARK: - LSP
extension ArticleViewModel {
    func getArticleTitle() -> String {
        
        return self.article.title
    }
    
    func getArticleURL() -> String {
        
        return self.article.articleURL
    }
    
    func getArticleId() -> Int {
        
        return self.article.id
    }
    
    func getArticleMetaData() -> ArticleMetadata {
        
        return self.article.articleMetadata
    }
    
    func getArticleAuxiliaryData() -> ArticleAuxiliaryData {
        
        return self.article.articleAuxiliaryData
    }
}
