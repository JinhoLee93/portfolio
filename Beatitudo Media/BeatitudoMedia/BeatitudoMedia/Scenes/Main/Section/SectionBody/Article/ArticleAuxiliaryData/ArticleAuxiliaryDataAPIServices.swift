//
//  ArticleAuxiliaryDataAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/27/24.
//

import Foundation

class ArticleAuxiliaryDataAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var articleAuxiliaryData: ArticleAuxiliaryData?
    @Published var user: BeatitudoMediaUser?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func updateLoved(currentUserId: Int, currentArticleId: Int) async throws {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/update-loved-articles/"
        let parameters: [String : Any] = ["current_user_id" : currentUserId, "current_article_id" : currentArticleId]
        let updatedUser: BeatitudoMediaUserWrapper? = try await domain.post(url: url, parameters: parameters)
        await MainActor.run { user = updatedUser?.beatitudoMediaUser }
        GlobalAssets.currentUser = user
    }
    
    func updateCountOfLoved(currentArticleId: Int, shouldIncrement: Bool) async throws {
        let url = "http://\(GlobalAssets.serverIP)/sections/update-count-of-loved/"
        let parameters: [String : Any] = ["current_article_id" : currentArticleId, "should_increment" : shouldIncrement]
        let updatedArticleAuxiliaryData: ArticleAuxiliaryData? = try await domain.put(url: url, parameters: parameters)
        await MainActor.run { articleAuxiliaryData = updatedArticleAuxiliaryData }
    }
}
