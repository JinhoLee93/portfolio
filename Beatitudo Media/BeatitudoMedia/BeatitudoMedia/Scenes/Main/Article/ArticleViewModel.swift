//
//  ArticleViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI
import Combine

protocol ArticleViewModelType {
    func getArticleTitle() -> String
}

class ArticleViewModel: ObservableObject, ArticleViewModelType {
    private var article: Article
    @Published var thumbnail: Image?
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let articleAPIServices: ArticleAPIServices
    
    init(domain: NetworkLayer = APIServices.shared, article: Article) {
        self.article = article
        self.articleAPIServices = ArticleAPIServices(article: article)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        self.articleAPIServices.$thumbnail
            .sink { [weak self] in
                if let thumbnail = $0 {
                    self?.thumbnail = thumbnail
                }
            }
            .store(in: &anyCancellables)
    }
    
    func getArticleTitle() -> String {
        
        return self.article.title
    }
}
