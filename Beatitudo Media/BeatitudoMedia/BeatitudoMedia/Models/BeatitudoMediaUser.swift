//
//  BeatitudoMediaUser.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import Foundation

struct BeatitudoMediaUserLovedArticles: Codable, Hashable {
    let articleId: Int
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
    }
}

struct BeatitudoMediaUserViewedArticles: Codable, Hashable {
    let articleId: Int
    
    enum CodingKeys: String, CodingKey {
        case articleId = "article_id"
    }
}

struct BeatitudoMediaUser: Codable, Hashable {
    let id: Int
    let email: String
    let nickname: String
    let lovedArticles: [BeatitudoMediaUserLovedArticles]
    let viewedArticles: [BeatitudoMediaUserViewedArticles]
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case lovedArticles = "loved_articles"
        case viewedArticles = "viewed_articles"
    }
}
