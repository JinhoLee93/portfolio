//
//  ArticleBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import SwiftUI

struct ArticleAuxiliaryDataBar: View {
    @StateObject private var viewModel: ArticleAuxiliaryDataViewModel
    
    @Binding var presentingReportSheet: Bool
    @Binding var isUserSignedIn: Bool
    @Binding var showSigningSheet: Bool
    
    @State private var presentingShared: Bool = false
    @State private var isLiked: Bool = false
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String, presentingReportSheet: Binding<Bool>, isUserSignedIn: Binding<Bool>, showSigningSheet: Binding<Bool>) {
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
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(isLiked ? .pink : .adaptiveView)
                        
                        Text("\(viewModel.getCountOfLoved())")
                            .font(.system(size: 10))
                            .foregroundStyle(viewModel.getLoved() ? .pink : .adaptiveView)
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
                    .onTapGesture {
                        isLiked.toggle()
//                        if isUserSignedIn {
//                            viewModel.updateLoved()
//                        } else {
//                            withAnimation(.easeInOut(duration: 0.25)) {
//                                showSigningSheet = true
//                            }
//                        }
                    }
                    .sensoryFeedback(.selection, trigger: viewModel.getCountOfLoved()) { oldValue, newValue in
                         
                        return oldValue < newValue
                    }
                    
                    Divider()
                        .background(.gray)
                    
                    ShareLink(item: URL(string: viewModel.getArticleURL())!) {
                        Image(systemName: "arrowshape.turn.up.right.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color.adaptiveView)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                    Divider()
                        .background(.gray)
                    
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
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                    .sensoryFeedback(.selection, trigger: presentingReportSheet) { oldValue, newValue in
                        
                        return newValue
                    }

                }
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.adaptiveView, lineWidth: 0.5)
                )
            }
        }
        .frame(height: 15)
    }
    
}

#Preview {
    BeatitudoMediaView()
}
