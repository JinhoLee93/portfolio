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
    
    private var taskManager: Task<Void, Error>?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func postNewUserWith(email: String, password: String, nickname: String) async throws {
        taskManager?.cancel()
        
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-new-user/"
        
        let authDataResult = try await AuthenticationManager.shared.signUpUserWithEmailandPassword(email: email, password: password)
        if let authDataResultEmail = authDataResult.email {
            let parameters: [String : Any] = ["email" : authDataResultEmail, "nickname": nickname]
            let wrapper: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
            await MainActor.run { self.user = wrapper.beatitudoMediaUser }
        }
    }
}

