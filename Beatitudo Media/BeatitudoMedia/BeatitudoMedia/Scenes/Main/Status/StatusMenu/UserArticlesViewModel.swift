//
//  UserArticlesViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import Foundation
import Combine

@MainActor
class UserArticlesViewModel: ObservableObject {
    private let domain = UserArticlesAPIServices()
    
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var articles: [Article]?
    
    init() {
        addSubscribers()
    }
}

// MARK: - View
extension UserArticlesViewModel {
    func sortArticlesBy(method: SortingMethod) {
        switch method {
        case .countOfLoved:
            articles = articles?.sorted { $0.articleAuxiliaryData.countOfLoved > $1.articleAuxiliaryData.countOfLoved }
        case .latest:
            articles = articles?.sorted { $0.articleMetadata.date > $1.articleMetadata.date }
        case .oldest:
            articles = articles?.sorted { $0.articleMetadata.date < $1.articleMetadata.date }
        case .countOfViews:
            articles = articles?.sorted { $0.articleMetadata.articleViews > $1.articleMetadata.articleViews }
        }
    }
}

// MARK: - API
extension UserArticlesViewModel {
    func translateUserArticlesIntoArticles(isForViewedArticles: Bool) async throws {
        try await domain.translateUserArticlesIntoArticles(isForViewedArticles: isForViewedArticles)
    }
}

// MARK: - Combine
extension UserArticlesViewModel {
    func addSubscribers() {
        self.domain.$articles
            .sink { [weak self] in
                self?.articles = $0
                self?.sortArticlesBy(method: .countOfLoved)
            }
            .store(in: &anyCancellables)
    }
}
