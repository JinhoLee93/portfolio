//
//  ArticleMetadata.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

struct ArticleMetadata {
    let views: Int
    let timeToRead: Int
    let date: String
    
    func updateViews() -> ArticleMetadata {
        
        return ArticleMetadata(views: self.views + 1, timeToRead: self.timeToRead, date: self.date)
    }
}
