//
//  BeatitudoMediaUser.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import Foundation

struct BeatitudoMediaUser: Codable, Hashable {
    let id: Int
    let email: String
    let nickname: String
    let likedArticles: [Article]
    let viewedArticles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case viewedArticles = "viewed_articles"
        case likedArticles = "liked_articles"
    }
}
