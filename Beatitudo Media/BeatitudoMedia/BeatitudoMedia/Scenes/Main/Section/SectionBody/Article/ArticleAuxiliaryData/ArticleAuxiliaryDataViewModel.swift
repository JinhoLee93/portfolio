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
    
    @Published var isLoved : Bool
    @Published var countOfLoved: Int
    
    private let articleURL : String
    private let articleId  : Int
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self.articleURL = articleURL
        self.articleId = articleAuxiliaryData.articleId
        self.isLoved = GlobalAssets.currentUser?.lovedArticles.contains { $0.articleId == articleAuxiliaryData.articleId } ?? false
        self.countOfLoved = articleAuxiliaryData.countOfLoved
        addSubscribers()
    }
}

// MARK: - API
extension ArticleAuxiliaryDataViewModel {
    func updateLoved() async throws {
        guard let currentUserId = GlobalAssets.currentUserID, let articleAuxiliaryData = self.articleAuxiliaryData else { return }
        try await domain.updateLoved(currentUserId: currentUserId,
                                     currentArticleId: articleAuxiliaryData.articleId)
    }
    
    func updateCountOfLoved() async throws {
        guard let articleAuxiliaryData = self.articleAuxiliaryData else { return }
        try await domain.updateCountOfLoved(currentArticleId: articleAuxiliaryData.articleId,
                                            shouldIncrement: isLoved)
    }
}

// MARK: - Combine
extension ArticleAuxiliaryDataViewModel {
    func addSubscribers() {
        domain.$articleAuxiliaryData
            .sink { [weak self] in
                guard let articleAuxiliaryData = $0 else { return }
                
                self?.articleAuxiliaryData = articleAuxiliaryData
                self?.countOfLoved = articleAuxiliaryData.countOfLoved
            }
            .store(in: &anyCancellables)
        
        domain.$user
            .sink { [weak self] in
                guard let updatedUser = $0 else { return }
                
                self?.isLoved = updatedUser.lovedArticles.contains { $0.articleId == self?.articleId }
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
