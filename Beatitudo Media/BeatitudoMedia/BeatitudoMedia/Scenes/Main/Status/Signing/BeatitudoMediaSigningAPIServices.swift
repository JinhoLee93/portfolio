//
//  BeatitudoMediaSigningAPIServices.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/25/24.
//

import Foundation

class BeatitudoMediaSigningAPIServices: ObservableObject {
    private let domain: NetworkLayer
    
    @Published var user: BeatitudoMediaUser?
    
    init(domain: NetworkLayer = APIServices.shared) {
        self.domain = domain
    }
    
    func signUpWithGoogle() async throws {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-user/"
        
        let authDataResultModel = try await AuthenticationManager.shared.signInWithGoogle()
        if let authDataResultEmail = authDataResultModel.email {
            let parameters: [String : Any] = ["email" : authDataResultEmail, "nickname" : Utils.divideEmailIntoTokens(email: authDataResultEmail)[0]]
            print("parameters \(parameters)")
            let wrapper: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
            await MainActor.run { self.user = wrapper.beatitudoMediaUser }
        }
    }
    
    func signInWithGoogle() async throws {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-user/"
        
        let authDataResultModel = try await AuthenticationManager.shared.signInWithGoogle()
        if let authDataResultEmail = authDataResultModel.email {
            let parameters: [String : Any] = ["email" : authDataResultEmail]
            let wrapper: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
            await MainActor.run { self.user = wrapper.beatitudoMediaUser }
        }
    }
}
