//
//  EmailSigningViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import Foundation
import Peppermint
import Combine

class EmailSigningViewModel: ObservableObject {
    private let domain = EmailSigningAPIServices()
    
    @Published var user: BeatitudoMediaUser?
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
    
    func signUp() async throws -> BeatitudoMediaUser {
        let user: BeatitudoMediaUser = try await domain.postNewUserWith(email: email, nickname: nickname)
        
        return user
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
    
    func resetEmail() {
        email = ""
        isValidEmail = false
    }
}
