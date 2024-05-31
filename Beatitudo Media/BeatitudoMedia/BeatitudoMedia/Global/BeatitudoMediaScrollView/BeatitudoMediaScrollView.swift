//
//  BeatitudoMediaScrollView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/31/24.
//

import SwiftUI
import UIKit

struct BeatitudoMediaScrollView<Content: View>: View {
    @StateObject private var viewModel = BeatitudoMediaScrollViewModel()
    
    var content: Content
    var onRefresh: () async -> ()
    
    init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () async -> ()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    @State private var rotationDegrees = 0.0
    private var animation: Animation {
        .linear
        .speed(0.1)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack {
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
//                        .clipShape(Circle().trim(from: 0, to: viewModel.progress).stroke(lineWidth: 20))
                        .rotationEffect(.degrees(rotationDegrees))
                        
                }
                .frame(height: 50 * viewModel.progress)
                .offset(y: viewModel.isEligible ? -(viewModel.contentOffsetY < 0 ? 0 : viewModel.contentOffsetY) : -(viewModel.scrollOffsetY < 0 ? 0 : viewModel.scrollOffsetY))

                content
            }
            .offset(coordinateSpace: "BeatitudoMediaScrollView") { offsetY in
                viewModel.contentOffsetY = offsetY
                
                if !viewModel.isEligible {
                    var progress = offsetY / 100
                    progress = (progress < 0 ? 0 : progress)
                    progress = (progress > 1 ? 1 : progress)
                    viewModel.scrollOffsetY = offsetY
                    viewModel.progress = progress
                }
                
                if viewModel.isEligible && !viewModel.isRefreshing {
                    viewModel.isRefreshing = true
                }
            }
            .sensoryFeedback(.impact, trigger: viewModel.isRefreshing)
        }
        .coordinateSpace(name: "BeatitudoMediaScrollView")
        .onAppear(perform: viewModel.addGesture)
        .onDisappear(perform: viewModel.removeGesture)
        .onChange(of: viewModel.isRefreshing) { _, newValue in
            if newValue {
                Task {
                    withAnimation(animation) {
                        rotationDegrees = 360.0
                    }
                    await onRefresh()
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.isEligible = false
                        viewModel.isRefreshing = false
                        viewModel.scrollOffsetY = 0
                        rotationDegrees = 0
                        viewModel.progress = 0
                    }
                }
            }
        }
    }
}

class BeatitudoMediaScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    @Published var isEligible: Bool        = false
    @Published var isRefreshing: Bool      = false
    @Published var scrollOffsetY: CGFloat  = 0
    @Published var contentOffsetY: CGFloat = 0
    @Published var progress: CGFloat       = 0
}

// MARK: - Pan Gesture
extension BeatitudoMediaScrollViewModel {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesture: )))
        panGesture.delegate = self
        
        rootController().view.addGestureRecognizer(panGesture)
    }
    
    func removeGesture() {
        rootController().view.gestureRecognizers?.removeAll()
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
            print("User released Touch")
            if scrollOffsetY >= 100 {
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
