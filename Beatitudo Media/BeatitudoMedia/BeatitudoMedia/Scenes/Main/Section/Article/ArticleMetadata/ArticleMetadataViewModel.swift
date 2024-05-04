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
    
    func getTimeToRead() -> Int {
        
        return self.articleMetadata.timeToRead
    }
    
    func getViews() -> Int {
        
        return self.articleMetadata.views
    }
    
    func getDate() -> String {
        
        return self.articleMetadata.date
    }
}
