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
    @Published var articleViews: Int
    
    private var anyCancellables = Set<AnyCancellable>()
    
    private let articleAPIServices: ArticleAPIServices
    
    init(domain: NetworkLayer = APIServices.shared, article: Article) {
        self.article = article
        self.articleAPIServices = ArticleAPIServices(article: article)
        self.articleViews = 0
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
    
    func getArticleURL() -> String {
        
        return self.article.articleURL
    }
    
    func getArticleMetaData() -> ArticleMetadata {
        
        return self.article.articleMetadata
    }
    
    func getArticleAuxiliaryData() -> ArticleAuxiliaryData {
        
        return self.article.articleAuxiliaryData
    }
    
    func updateViews() {
        self.article = self.article.updateViews()
        self.articleViews = self.article.articleViews
    }
}
