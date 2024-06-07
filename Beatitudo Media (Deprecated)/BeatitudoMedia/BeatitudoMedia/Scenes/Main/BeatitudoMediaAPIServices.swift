//
//  BeatitudoMediaAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/14/24.
//

import Foundation

class BeatitudoMediaAPIServices {
    private let domain: NetworkLayer
    
    @Published var sections: [Section] = []
    @Published var currentUser: BeatitudoMediaUser? = nil
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func refreshSections() async throws {
        let url = "http://\(GlobalAssets.serverIp)/beatitudo-media-sections/send-sections/"
        let fetchedSections: Sections = try await domain.get(url: url)
        
        await MainActor.run { self.sections = fetchedSections.returnSortedSectionsWithSortedArticles().sections }
    }
    
    func fetchCurrentUser() async throws {
        let url = "http://\(GlobalAssets.serverIp)/beatitudo-media-users/user-related/"
        guard let currentUserID = GlobalAssets.currentUserId else { return }
        let parameters: [String : Int] = ["id" : currentUserID]
        let fetchedUser: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
        self.currentUser = fetchedUser.beatitudoMediaUser
    }
}
