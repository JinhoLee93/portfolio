//
//  ArticleMetadata.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleMetadata: Codable, Hashable {
    let id: Int
    let articleId: Int
    let timeToRead: Int
    let date: String
    let articleViews: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case articleId = "article_id"
        case timeToRead = "time_to_read"
        case date
        case articleViews = "article_views"
    }
}
