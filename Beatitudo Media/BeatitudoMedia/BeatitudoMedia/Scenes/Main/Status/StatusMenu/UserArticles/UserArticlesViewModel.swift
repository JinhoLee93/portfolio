//
//  UserArticlesViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/29/24.
//

import Foundation
import Combine
import UIKit
import SwiftUI

@MainActor
class UserArticlesViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    private let domain = UserArticlesAPIServices()
    private var anyCancellables = Set<AnyCancellable>()
    
    @Published var articles: [Article]?
    @Published var offsetX: CGFloat = 0
    @Published var isMoving: Bool   = false
    
    let maxWidth = UIScreen.main.bounds.width
    
    override init() {
        super.init()
        addSubscribers()
    }
}

// MARK: - View
extension UserArticlesViewModel {
    func sortArticlesBy(method: SortingMethod) {
        switch method {
        case .countOfLoved:
            articles = articles?.sorted { $0.articleAuxiliaryData.countOfLoved > $1.articleAuxiliaryData.countOfLoved }
        case .latest:
            articles = articles?.sorted { $0.articleMetadata.date > $1.articleMetadata.date }
        case .oldest:
            articles = articles?.sorted { $0.articleMetadata.date < $1.articleMetadata.date }
        case .countOfViews:
            articles = articles?.sorted { $0.articleMetadata.articleViews > $1.articleMetadata.articleViews }
        }
    }
}

// MARK: - API
extension UserArticlesViewModel {
    func translateUserArticlesIntoArticles(isForViewedArticles: Bool) async throws {
        try await domain.translateUserArticlesIntoArticles(isForViewedArticles: isForViewedArticles)
    }
}

// MARK: - Combine
extension UserArticlesViewModel {
    func addSubscribers() {
        self.domain.$articles
            .sink { [weak self] in
                self?.articles = $0
                self?.sortArticlesBy(method: .countOfLoved)
            }
            .store(in: &anyCancellables)
    }
}

// MARK: - Pan Gesture
extension UserArticlesViewModel {
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
