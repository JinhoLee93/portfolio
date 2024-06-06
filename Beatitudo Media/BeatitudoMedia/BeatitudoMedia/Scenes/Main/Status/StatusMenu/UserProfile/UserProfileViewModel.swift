//
//  UserProfileViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import Foundation
import Combine
import SwiftUI
import UIKit

@MainActor
class UserProfileViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
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
    
    override init() {
        email = GlobalAssets.currentUserEmail ?? ""
        nicknamePlaceholder = GlobalAssets.currentUserNickname ?? ""
        nickname = GlobalAssets.currentUserNickname ?? ""
        super.init()
        addSubscribers()
    }
    
    @Published var offsetX: CGFloat = 0
}

// MARK: - Combine
extension UserProfileViewModel {
    private func addSubscribers() {
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

// MARK: - Pan Gesture
extension UserProfileViewModel {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesture: )))
        panGesture.delegate = self
        
        Utils.topViewController()?.view.gestureRecognizers?.append(panGesture)
    }
    
    func removeGesture() {
        Utils.topViewController()?.view.gestureRecognizers?.removeAll()
    }
    
    @objc
    func onGestureChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view).x
        offsetX = translation
        if gesture.state == .cancelled || gesture.state == .ended {
            if abs(offsetX) >= GlobalAssets.maxWidth * 0.5 || gesture.velocity(in: Utils.topViewController()?.view).x < -2000 {
                withAnimation(.easeInOut(duration: 0.1)) {
                    offsetX = -GlobalAssets.maxWidth
                }
            } else {
                withAnimation(.easeInOut(duration: 0.1)) {
                    offsetX = 0
                }
            }
        }
    }
}
