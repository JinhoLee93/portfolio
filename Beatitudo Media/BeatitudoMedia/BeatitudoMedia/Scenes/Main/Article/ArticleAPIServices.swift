//
//  ArticleAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation
import SwiftUI
import Combine

class ArticleAPIServices {
    @Published var thumbnail: Image?
    
    private let domain: NetworkLayer
    
    private var imageTask: Task<Void, Error>?
    
    init(domain: NetworkLayer = APIServices.shared, article: Article) {
        self.domain = domain
        self.imageTask?.cancel()
        self.imageTask = Task {
            if let thumbnail = try await self.domain.downloadImage(url: article.thumbnailURL) {
                await MainActor.run { self.thumbnail = thumbnail }
            }
        }
    }
}
