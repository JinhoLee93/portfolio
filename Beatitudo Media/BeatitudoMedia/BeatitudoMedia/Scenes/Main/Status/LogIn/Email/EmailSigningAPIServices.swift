//
//  EmailSigningAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/23/24.
//

import Foundation

class EmailSigningAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var user: BeatitudoMediaUser?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func postNewUserWith(email: String, nickname: String) async throws -> BeatitudoMediaUser {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-new-user/"
        let parameters: [String : Any] = ["email" : email,
                                          "nickname": nickname]
        let user: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
        
        return user.beatitudoMediaUser
    }
}
