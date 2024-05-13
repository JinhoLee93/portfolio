//
//  Article.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import Foundation

struct Article: Hashable, Codable {
    let title: String
    let articleViews: Int
    let thumbnailURL: String
    let articleURL: String
    let articleMetadataURL: String
    let articleAuxiliaryDataURL: String
    
    func updateViews() -> Article {
        
        return Article(title: self.title,
                       articleViews: self.articleViews + 1,
                       thumbnailURL: self.thumbnailURL,
                       articleURL: self.articleURL,
                       articleMetadataURL: self.articleMetadataURL,
                       articleAuxiliaryDataURL: self.articleAuxiliaryDataURL)
    }
}
