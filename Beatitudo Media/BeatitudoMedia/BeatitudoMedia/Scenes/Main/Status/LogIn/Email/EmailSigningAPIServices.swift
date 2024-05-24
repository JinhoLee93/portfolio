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
    
    func postNewUserWith(email: String, password: String, nickname: String) async {
        let url = "http://\(GlobalAssets.serverIP)/beatitudo-media-users/post-new-user/"
        let parameters: [String : Any] = ["email" : email,
                                          "nickname": nickname]
        Task {
            do {
                let _ = try await AuthenticationManager.shared.signUpUserWithEmailandPassword(email: email, password: password)
                let wrapper: BeatitudoMediaUserWrapper = try await domain.post(url: url, parameters: parameters)
                
                await MainActor.run { self.user = wrapper.beatitudoMediaUser }
            } catch {
                print("\(error.localizedDescription) occurred creating a new user with \(email)")
            }
        }
    }
}

