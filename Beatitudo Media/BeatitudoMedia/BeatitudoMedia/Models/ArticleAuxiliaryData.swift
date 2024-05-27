//
//  ArticleAuxiliaryData.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleAuxiliaryData: Codable, Hashable {
    let id: Int
    let articleId: Int
    let countOfLoved: Int
    let countOfShared: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case articleId = "article_id"
        case countOfLoved = "count_of_loved"
        case countOfShared = "count_of_shared"
    }
}
