//
//  ArticleAuxiliaryData.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleAuxiliaryData: Codable, Hashable {
    let countOfLoved: Int
    let countOfShared: Int
    
    enum CodingKeys: String, CodingKey {
        case countOfLoved = "count_of_loved"
        case countOfShared = "count_of_shared"
    }
//
//    func updateLoved() -> ArticleAuxiliaryData {
//        
//        return ArticleAuxiliaryData(countOfLoved: self.loved ? self.countOfLoved - 1 : self.countOfLoved + 1,
//                                    countOfShared: self.countOfShared)
//    }
}
