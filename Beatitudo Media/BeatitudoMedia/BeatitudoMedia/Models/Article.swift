//
//  Article.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import Foundation

struct Articles: Codable, Hashable {
    let articles: [Article]
}

struct Article: Codable, Hashable {
    let id: Int
    let title: String
    let thumbnailURL: String
    let articleURL: String
    let articleMetadata: ArticleMetadata
    let articleAuxiliaryData: ArticleAuxiliaryData
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailURL = "thumbnail_url"
        case articleURL = "article_url"
        case articleMetadata = "article_metadata"
        case articleAuxiliaryData = "article_auxiliary_data"
    }
    
    func updateViews() -> Article {
        
        return Article(id: self.id,
                       title: self.title,
                       thumbnailURL: self.thumbnailURL,
                       articleURL: self.articleURL,
                       articleMetadata: self.articleMetadata,
                       articleAuxiliaryData: self.articleAuxiliaryData)
    }
}
