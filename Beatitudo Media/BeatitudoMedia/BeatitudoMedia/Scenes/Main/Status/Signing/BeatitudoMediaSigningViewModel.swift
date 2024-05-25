//
//  BeatitudoMediaSigningViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/22/24.
//

import Foundation
import Combine

class BeatitudoMediaSigningViewModel: ObservableObject {
    private let domain = BeatitudoMediaSigningAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var user: BeatitudoMediaUser?
    @Published private var signingMethods = ["Google", "Email"]
    
    init() {
        addSubscribers()
    }
}

// MARK: - Helpers
extension BeatitudoMediaSigningViewModel {
    func getSigningMethods() -> [String] {
        
        return signingMethods
    }
    
    func getSigningMethodsCount() -> Int {
        
        return signingMethods.count
    }
}

// MARK: - Signing
extension BeatitudoMediaSigningViewModel {
    func signUpWithGoogle() async throws {
        try await domain.signUpWithGoogle()
    }
    
    func signInWithGoogle() async throws {
        try await domain.signInWithGoogle()
    }
}

// MARK: - Combine
extension BeatitudoMediaSigningViewModel {
    func addSubscribers() {
        domain.$user
            .sink { [weak self] in
                self?.user = $0
                GlobalAssets.signUpOrInUser(id: $0?.id, email: $0?.email, nickname: $0?.nickname)
            }
            .store(in: &anyCancellables)
    }
}
