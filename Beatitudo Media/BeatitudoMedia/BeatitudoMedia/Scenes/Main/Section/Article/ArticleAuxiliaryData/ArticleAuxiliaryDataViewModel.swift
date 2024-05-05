//
//  ArticleAuxiliaryDataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

class ArticleAuxiliaryDataViewModel: ObservableObject {
    @Published var articleAuxiliaryData: ArticleAuxiliaryData
    
    private let articleURL: String
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self.articleURL = articleURL
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
    }
    
    func getArticleURL() -> String {
        
        return self.articleURL
    }
}
