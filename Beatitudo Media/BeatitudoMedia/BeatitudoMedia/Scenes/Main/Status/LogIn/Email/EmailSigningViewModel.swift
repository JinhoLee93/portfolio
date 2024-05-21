//
//  EmailSigningViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import Foundation

class EmailSigningViewModel: ObservableObject {
    @Published var email    = ""
    @Published var password = ""
    @Published var nickname = ""
    
    func signUp() {
        Task {
            do {
                try await AuthenticationManager.shared.createUser(email: email, password: password)
            } catch let error {
                print("\(error) creating user")
            }
        }
    }
    
    func findPassword(email: String) {
        
        return
    }
}
