//
//  ArticleBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import SwiftUI

struct ArticleAuxiliaryDataBar: View {
    private var articleAuxiliaryData: ArticleAuxiliaryData
    
    @StateObject private var viewModel: ArticleAuxiliaryDataViewModel
    
    @Binding var presentingReportSheet: Bool
    @Binding var isUserSignedIn: Bool
    @Binding var showSigningSheet: Bool
    
    @State private var presentingShared: Bool = false
    @State private var isAnimating: Bool      = false
    @State private var justTappedLove: Bool   = false
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String, presentingReportSheet: Binding<Bool>, isUserSignedIn: Binding<Bool>, showSigningSheet: Binding<Bool>) {
        self.articleAuxiliaryData = articleAuxiliaryData
        self._viewModel = StateObject(wrappedValue:
                                        ArticleAuxiliaryDataViewModel(articleAuxiliaryData: articleAuxiliaryData, articleURL: articleURL))
        self._presentingReportSheet = presentingReportSheet
        self._isUserSignedIn = isUserSignedIn
        self._showSigningSheet = showSigningSheet
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            HStack {
                Spacer()
                
                HStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: viewModel.isLoved ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(viewModel.isLoved ? .pink : .adaptiveView)
                            .offset(y: isAnimating ? -15 : 0.0)
                            .rotation3DEffect(
                                Angle(degrees: isAnimating ? 180.0 : 0.0),
                                axis: (x: 0.0, y: 1.0, z: 0.0),
                                perspective: 0
                            )
                        
                        Text("\(viewModel.countOfLoved)")
                            .font(.system(size: 10))
                            .foregroundStyle(viewModel.isLoved ? .pink : .adaptiveView)
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .onTapGesture {
                        if isUserSignedIn {
                            if !viewModel.isLoved {
                                justTappedLove = true
                            } else {
                                justTappedLove = false
                            }
                            
                            if !viewModel.isLoved {
                                withAnimation(.spring(duration: 0.2, bounce: 0.5)) {
                                    isAnimating = true
                                } completion: {
                                    withAnimation(.spring(duration: 0.2, bounce: 0.5)) {
                                        isAnimating = false
                                    }
                                }
                            }
                            
                            Task {
                                do {
                                    try await viewModel.updateLoved()
                                    
                                    try await viewModel.updateCountOfLoved()
                                    
                                    viewModel.isLoved.toggle()
                                } catch {
                                    print("\(error) occurred updating loved.")
                                }
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showSigningSheet = true
                            }
                        }
                    }
                    .sensoryFeedback(.selection, trigger: justTappedLove) { oldValue, newValue in
                            
                        return newValue
                    }
                    
                    ShareLink(item: URL(string: viewModel.getArticleURL())!) {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color.adaptiveView)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    
                    Button {
                        withAnimation(.spring(duration: 0.25)) { presentingReportSheet = true }
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color.adaptiveView)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
                    .sensoryFeedback(.selection, trigger: presentingReportSheet) { oldValue, newValue in
                        
                        return newValue
                    }

                }
            }
        }
        .frame(height: 15)
        .onChange(of: isUserSignedIn) { _, _ in
            viewModel.resetViewModel(articleAuxiliaryData: articleAuxiliaryData)
        }
        .onAppear {
            viewModel.resetViewModel(articleAuxiliaryData: articleAuxiliaryData)
        }
    }
}

#Preview {
    BeatitudoMediaView(isLightModeOn: .constant(true))
}
