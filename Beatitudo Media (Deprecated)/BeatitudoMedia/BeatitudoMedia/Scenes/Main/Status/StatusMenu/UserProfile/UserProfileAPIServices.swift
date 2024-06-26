//
//  UserProfileAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/30/24.
//

import Foundation

class UserProfileAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var user: BeatitudoMediaUser?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func changeUserNickname(newNickname: String) async throws {
        guard let currentUserId = GlobalAssets.currentUserId else { return }
        let url = "http://\(GlobalAssets.serverIp)/beatitudo-media-users/user-related/"
        let parameters: [String : Any] = ["current_user_id" : currentUserId,
                                          "new_nickname" : newNickname]
        
        let updatedUser: BeatitudoMediaUserWrapper = try await domain.put(url: url, parameters: parameters)
        await MainActor.run { user = updatedUser.beatitudoMediaUser }
    }
}
