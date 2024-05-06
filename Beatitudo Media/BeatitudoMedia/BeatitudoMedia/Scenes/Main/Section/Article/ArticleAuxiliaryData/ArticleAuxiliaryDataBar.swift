//
//  ArticleBar.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/3/24.
//

import SwiftUI

struct ArticleAuxiliaryDataBar: View {
    @StateObject private var viewModel: ArticleAuxiliaryDataViewModel
    
    init(articleAuxiliaryData: ArticleAuxiliaryData, articleURL: String) {
        self._viewModel = StateObject(wrappedValue:
                                        ArticleAuxiliaryDataViewModel(articleAuxiliaryData: articleAuxiliaryData, articleURL: articleURL))
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            HStack {
                Spacer()
                
                HStack(spacing: 5) {
                    HStack(spacing: 5) {
                        Image(systemName: self.viewModel.getLoved() ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15, height: 15)
                            .foregroundStyle(self.viewModel.getLoved() ? .pink : .adaptiveView)
                        
                        Text("\(self.viewModel.getCountOfLoved())")
                            .font(.system(size: 10))
                            .foregroundStyle(self.viewModel.getLoved() ? .pink : .adaptiveView)
                    }
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 5))
                    .onTapGesture {
                        self.viewModel.updateLoved()
                    }
                    
                    Divider()
                        .background(.gray)
                    
                    HStack(spacing: 5) {
                        ShareLink(item: URL(string: self.viewModel.getArticleURL())!) {
                            Image(systemName: "arrowshape.turn.up.right")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundStyle(Color.adaptiveView)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Text("\(self.viewModel.getShared())")
                            .font(.system(size: 10))
                            .foregroundStyle(.adaptiveText)
                    }
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 10))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.adaptiveView)
                )
            }
        }
        .frame(height: 15)
    }
    
}

#Preview {
    BeatitudoMediaView()
}
