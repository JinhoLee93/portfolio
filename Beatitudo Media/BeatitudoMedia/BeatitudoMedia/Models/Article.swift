//
//  Article.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import Foundation

struct Article: Codable, Hashable {
    let title: String
    let articleViews: Int
    let thumbnailURL: String
    let articleURL: String
    let articleMetadata: ArticleMetadata
    let articleAuxiliaryData: ArticleAuxiliaryData
    
    enum CodingKeys: String, CodingKey {
        case title
        case articleViews = "article_views"
        case thumbnailURL = "thumbnail_url"
        case articleURL = "article_url"
        case articleMetadata = "article_metadata"
        case articleAuxiliaryData = "article_auxiliary_data"
    }
    
    func updateViews() -> Article {
        
        return Article(title: self.title,
                       articleViews: self.articleViews + 1,
                       thumbnailURL: self.thumbnailURL,
                       articleURL: self.articleURL,
                       articleMetadata: self.articleMetadata,
                       articleAuxiliaryData: self.articleAuxiliaryData)
    }
}
