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
    
    @State private var rotationDegrees = 0.0
    
    var content: Content
    var onRefresh: () async throws -> ()
    
    init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping () async throws -> ()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack {
                    Image(systemName: "gear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle().trim(from: 0, to: viewModel.progress).stroke(lineWidth: 30))
                        .rotationEffect(.degrees(rotationDegrees))
                }
                .frame(height: 60 * viewModel.progress)
                .offset(y: viewModel.isEligible ? -(viewModel.contentOffsetY < 0 ? 0 : viewModel.contentOffsetY) : -(viewModel.scrollOffsetY < 0 ? 0 : viewModel.scrollOffsetY))

                content
                
                Spacer()
                    .frame(height: 20)
            }
            .offset(coordinateSpace: "BeatitudoMediaScrollView") { offsetY in
                viewModel.contentOffsetY = offsetY
                if !viewModel.isEligible {
                    var progress = offsetY / 60
                    progress = (progress < 0 ? 0 : progress)
                    progress = (progress > 1 ? 1 : progress)
                    viewModel.scrollOffsetY = offsetY
                    viewModel.progress = progress
                }
                
                if viewModel.isEligible && !self.viewModel.isRefreshing {
                    viewModel.isRefreshing = true
                }
            }
            .sensoryFeedback(.impact, trigger: viewModel.isRefreshing)
        }
        .coordinateSpace(name: "BeatitudoMediaScrollView")
        .onAppear {
            if viewModel.isInitialLoad {
                viewModel.addGesture()
                viewModel.isInitialLoad = false
            }
        }
        .onChange(of: viewModel.isRefreshing) { _, newValue in
            if newValue {
                Task {
                    withAnimation(.linear(duration: 0.25).speed(0.1).repeatForever(autoreverses: false)) {
                        rotationDegrees = 180
                    }
                    do {
                        try await onRefresh()
                    } catch {
                        print("\(error) occurred refreshing the sections.")
                        try await Task.sleep(for: .seconds(1.5))
                        withAnimation(.easeInOut(duration: 0.25)) {
                            rotationDegrees = 0
                            viewModel.progress = 0
                            viewModel.scrollOffsetY = 0
                            viewModel.isEligible = false
                            viewModel.isRefreshing = false
                        }
                    }
                    
                    try await Task.sleep(for: .seconds(1.5))
                    withAnimation(.easeInOut(duration: 0.25)) {
                        rotationDegrees = 0
                        viewModel.progress = 0
                        viewModel.scrollOffsetY = 0
                        viewModel.isEligible = false
                        viewModel.isRefreshing = false
                    }
                }
            }
        }
    }
}
