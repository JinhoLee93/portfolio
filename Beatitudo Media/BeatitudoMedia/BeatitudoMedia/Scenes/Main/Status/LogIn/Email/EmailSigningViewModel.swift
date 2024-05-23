//
//  EmailSigningViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import Foundation
import Peppermint

class EmailSigningViewModel: ObservableObject {
    @Published var isValidEmail = true
    @Published var email    = "" {
        willSet {
            let predicate = EmailPredicate()
            isValidEmail = predicate.evaluate(with: newValue)
        }
    }
    
    @Published var isValidPassword = true
    @Published var password = "" {
        willSet {
            isValidPassword = newValue.count > 5
        }
    }
    
    @Published var isValidNickname = true
    @Published var nickname = "" {
        willSet {
            isValidNickname = newValue.count > 1
        }
    }
    
    func signUp() async throws {
        do {
            try await AuthenticationManager.shared.createUserWithEmailandPassword(email: email, password: password)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn() async throws {
        do {
            try await AuthenticationManager.shared.signInUserWithEmailandPassword(email: email, password: password)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func findPassword(email: String) async throws {
        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
        } catch let error {
            print("\(error) finding password")
        }
    }

    func reset() {
        email = ""
        password = ""
        nickname = ""
        isValidEmail = true
        isValidPassword = true
        isValidNickname = true
    }
}
