//
//  BeatitudoMediaUser.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import Foundation

struct BeatitudoMediaUser: Codable, Hashable {
    let id: UUID
    let email: String
    let nickname: String
    let viewedArticles: [Article]
    let likedArticles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case viewedArticles = "viewed_articles"
        case likedArticles = "liked_articles"
    }
}
