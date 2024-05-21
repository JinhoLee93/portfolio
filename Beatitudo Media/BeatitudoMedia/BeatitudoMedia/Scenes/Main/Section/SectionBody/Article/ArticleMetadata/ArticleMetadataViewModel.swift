//
//  ArticleMetadataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

class ArticleMetadataViewModel: ObservableObject {
    @Published var articleMetadata: ArticleMetadata
    
    init(articleMetadata: ArticleMetadata) {
        self.articleMetadata = articleMetadata
    }
    
    func getArticleViews() -> Int {
        
        return self.articleMetadata.articleViews
    }
    
    func updateArticleViews() {
        APIServices.shared.updateViews(id: articleMetadata.id)
    }
    
    func getTimeToRead() -> Int {
        
        return self.articleMetadata.timeToRead
    }
    
    func getDate() -> String {
        
        return self.articleMetadata.date
    }
}
