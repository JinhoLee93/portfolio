//
//  UserProfileViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import Foundation
import Combine

@MainActor
class UserProfileViewModel: ObservableObject {
    private let domain = UserProfileAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var email: String
    @Published var nickname: String {
        willSet {
            isValidNickname = newValue.count >= 2
        }
    }
    @Published var nicknamePlaceholder: String
    @Published var isValidNickname: Bool = true
    
    init() {
        email = GlobalAssets.currentUserEmail ?? ""
        nicknamePlaceholder = GlobalAssets.currentUserNickname ?? ""
        nickname = GlobalAssets.currentUserNickname ?? ""
        addSubscribers()
    }
}

// MARK: - Combine
extension UserProfileViewModel {
    func addSubscribers() {
        domain.$user
            .sink { [weak self] in
                guard let user = $0 else { return }
                GlobalAssets.currentUser = user
                GlobalAssets.currentUserNickname = user.nickname
                self?.nickname = user.nickname
                self?.nicknamePlaceholder = user.nickname
            }
            .store(in: &anyCancellables)
    }
}

// MARK: - API
extension UserProfileViewModel {
    func changeUserNickname(newNickname: String) async throws {
        try await domain.changeUserNickname(newNickname: newNickname)
    }
}
