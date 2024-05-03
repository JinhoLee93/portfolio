//
//  ArticleAuxiliaryData.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleAuxiliaryData {
    let loved: Bool
    let countOfLoved: Int
    let shared: Int
    let comments: [ArticleComment]
    
    func updateShared() {
        
    }
    
    func updateLoved() -> ArticleAuxiliaryData {
        
        return ArticleAuxiliaryData(loved: !self.loved,
                                    countOfLoved: self.loved ? self.countOfLoved - 1 : self.countOfLoved + 1,
                                    shared: self.shared,
                                    comments: self.comments)
    }
}

struct ArticleComment {
    let body: String
}
