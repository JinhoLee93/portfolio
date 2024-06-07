//
//  BeatitudoMediaScrollViewModel.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/31/24.
//

import Foundation
import SwiftUI
import UIKit

class BeatitudoMediaScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    @Published var scrollOffsetY: CGFloat  = 0
    @Published var contentOffsetY: CGFloat = 0
    @Published var progress: CGFloat       = 0
    @Published var isEligible: Bool        = false
    @Published var isRefreshing: Bool      = false
    @Published var isInitialLoad: Bool     = true
}

// MARK: - Pan Gesture
extension BeatitudoMediaScrollViewModel {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
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
    
    func rootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    @objc
    func onGestureChange(gesture: UIPanGestureRecognizer) {
        if gesture.state == .cancelled || gesture.state == .ended {
            if self.scrollOffsetY >= 60 {
                isEligible = true
            } else {
                isEligible = false
            }
        }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
