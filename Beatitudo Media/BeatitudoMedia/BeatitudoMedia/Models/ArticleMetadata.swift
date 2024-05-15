//
//  ArticleMetadata.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleMetadata: Codable, Hashable {
    let timeToRead: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case timeToRead = "time_to_read"
        case date
    }
}
