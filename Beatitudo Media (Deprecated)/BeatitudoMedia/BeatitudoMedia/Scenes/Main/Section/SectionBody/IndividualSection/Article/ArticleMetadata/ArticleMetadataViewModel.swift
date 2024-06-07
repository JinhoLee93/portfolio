//
//  ArticleMetadataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

class ArticleMetadataViewModel: ObservableObject {
    var articleMetadata: ArticleMetadata
    
    init(articleMetadata: ArticleMetadata) {
        self.articleMetadata = articleMetadata
    }
}

// MARK: - Helpers
extension ArticleMetadataViewModel {
    func resetViewModel(articleMetadata: ArticleMetadata) {
        self.articleMetadata = articleMetadata
    }
}
