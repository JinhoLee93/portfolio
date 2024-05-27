//
//  ArticleAuxiliaryDataViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import Foundation

class ArticleAuxiliaryDataViewModel: ObservableObject {
    @Published private var articleAuxiliaryData: ArticleAuxiliaryData
    
    private let articleURL    : String
    private var countOfShared : Int
    private var countOfLoved  : Int
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self.articleURL = articleURL
        self.countOfShared = articleAuxiliaryData.countOfShared
        self.countOfLoved = articleAuxiliaryData.countOfLoved
    }
    
    func getLoved() -> Bool {
        
        return false
    }
    
    func getCountOfLoved() -> Int {
        
        return self.articleAuxiliaryData.countOfLoved
    }
    
    func getCountOfShared() -> Int {
        
        return self.articleAuxiliaryData.countOfShared
    }
    
    func updateLoved() {
//        guard let userID = GlobalAssets.currentUserID else { return }
//        APIServices.shared.put(id: articleAuxiliaryData.id, userUUID: userUUID)
        
    }
    
    func getArticleURL() -> String {
        
        return self.articleURL
    }
}
