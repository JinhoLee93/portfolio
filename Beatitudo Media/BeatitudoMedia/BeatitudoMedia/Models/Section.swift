//
//  Page.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 4/30/24.
//

import SwiftUI

struct Section: Codable, Hashable {
    let id: Int
    let title: String
    let articles: [Article]
}

extension Section {
    func returnSectionWithSortedArticles() -> Section {
        
        return Section(id: self.id, title: self.title, articles: self.articles.sorted { $0.id > $1.id })
    }
}
