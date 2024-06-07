//
//  EmailSigningViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/20/24.
//

import Foundation
import Peppermint
import Combine

@MainActor
class EmailSigningViewModel: ObservableObject {
    private let domain = EmailSigningAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
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
    
    init() {
        addSubscribers()
    }
}

// MARK: - Signing
extension EmailSigningViewModel {
    func signUp() async throws {
        try await domain.postNewUserWith(email: email, password: password, nickname: nickname)
    }
    
    func signIn() async throws {
        try await domain.signInUserWith(email: email, password: password)
    }
    
    func findPassword(email: String) async throws {
        do {
            try await AuthenticationManager.shared.resetPassword(email: email)
        } catch let error {
            print("\(error) finding password")
        }
    }
}

// MARK: - View
extension EmailSigningViewModel {
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

// MARK: - Combine
extension EmailSigningViewModel {
    func addSubscribers() {
        domain.$user
            .sink {
                GlobalAssets.signUpOrInUser(user: $0, id: $0?.id, email: $0?.email, nickname: $0?.nickname)
            }
            .store(in: &anyCancellables)
    }
}
