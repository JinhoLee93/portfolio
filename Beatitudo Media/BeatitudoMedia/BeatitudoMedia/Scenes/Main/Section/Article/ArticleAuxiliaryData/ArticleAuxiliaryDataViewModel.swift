//
//  ArticleAuxiliaryDataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

class ArticleAuxiliaryDataViewModel: ObservableObject {
    private var articleAuxiliaryData: ArticleAuxiliaryData
    private let articleURL: String
    
    @Published var countOfShared: Int
    @Published var countOfLoved: Int
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self.articleURL = articleURL
        self.countOfShared = articleAuxiliaryData.shared
        self.countOfLoved = articleAuxiliaryData.countOfLoved
    }
    
    func getLoved() -> Bool {
        
        return self.articleAuxiliaryData.loved
    }
    
    func getCountOfLoved() -> Int {
        
        return self.articleAuxiliaryData.countOfLoved
    }
    
    func getShared() -> Int {
        
        return self.articleAuxiliaryData.shared
    }
    
    func getComments() -> [ArticleComment] {
        
        return self.articleAuxiliaryData.comments
    }
    
    func getCommentsCount() -> Int {
        
        return self.articleAuxiliaryData.comments.count
    }
    
    func updateLoved() {
        self.articleAuxiliaryData = self.articleAuxiliaryData.updateLoved()
        self.countOfLoved = self.articleAuxiliaryData.countOfLoved
    }
    
    func getArticleURL() -> String {
        
        return self.articleURL
    }
}
