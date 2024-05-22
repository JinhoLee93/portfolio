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
    
    func signUp() async throws {
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
        } catch let error {
            print("\(error) creating user")
        }
    }
    
    func signIn() async throws {
        
    }
    
    func findPassword(email: String) async throws {
        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
        } catch let error {
            print("\(error) finding password")
        }
    }
}
