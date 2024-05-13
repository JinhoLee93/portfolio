//
//  ArticleAuxiliaryData.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleAuxiliaryData: Hashable {
    let loved: Bool
    let countOfLoved: Int
    let countOfShared: Int
//    let comments: [ArticleComment]
    
    func updateShared() {
        
    }
    
    func updateLoved() -> ArticleAuxiliaryData {
        
        return ArticleAuxiliaryData(loved: !self.loved,
                                    countOfLoved: self.loved ? self.countOfLoved - 1 : self.countOfLoved + 1,
                                    countOfShared: self.countOfShared)
    }
}
