//
//  ArticleAuxiliaryDataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import Combine

@MainActor
class ArticleAuxiliaryDataViewModel: ObservableObject {
    private let domain = ArticleAuxiliaryDataAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
    private var articleAuxiliaryData: ArticleAuxiliaryData?
    
    @Published var isLoved: Bool
    @Published var countOfLoved: Int
    
    private let articleURL: String
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self.articleURL = articleURL
        self.isLoved = GlobalAssets.currentUser?.lovedArticles.contains { $0.articleId == articleAuxiliaryData.articleId } ?? false
        self.countOfLoved = articleAuxiliaryData.countOfLoved
        addSubscribers()
    }
}

// MARK: - Helpers
extension ArticleAuxiliaryDataViewModel {
    func resetViewModel(articleAuxiliaryData: ArticleAuxiliaryData) {
        self.isLoved = GlobalAssets.currentUser?.lovedArticles.contains { $0.articleId == articleAuxiliaryData.articleId } ?? false
        self.countOfLoved = articleAuxiliaryData.countOfLoved
    }
}

// MARK: - API
extension ArticleAuxiliaryDataViewModel {
    func updateLoved() async throws {
        guard let currentUserId = GlobalAssets.currentUserId, let articleAuxiliaryData = self.articleAuxiliaryData else { return }
        try await domain.updateLoved(currentUserId: currentUserId,
                                     currentArticleId: articleAuxiliaryData.articleId)
    }
    
    func updateCountOfLoved() async throws {
        guard let articleAuxiliaryData = self.articleAuxiliaryData else { return }
        try await domain.updateCountOfLoved(currentArticleId: articleAuxiliaryData.articleId,
                                            shouldIncrement: !isLoved)
    }
}

// MARK: - Combine
extension ArticleAuxiliaryDataViewModel {
    func addSubscribers() {
        domain.$countOfLoved
            .sink { [weak self] in
                guard let countOfLoved = $0 else { return }
                self?.countOfLoved = countOfLoved
            }
            .store(in: &anyCancellables)
        
        domain.$user
            .sink {
                guard let currentUser = $0 else { return }
                GlobalAssets.currentUser = currentUser
            }
            .store(in: &anyCancellables)
    }
}

// MARK: - LSP
extension ArticleAuxiliaryDataViewModel {
    func getLoved() -> Bool {
        
        return false
    }
    
    func getArticleURL() -> String {
        
        return self.articleURL
    }
}
