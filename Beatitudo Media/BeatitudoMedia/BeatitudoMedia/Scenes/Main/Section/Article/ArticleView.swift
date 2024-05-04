//
//  ArticleView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

struct ArticleView: View {
    @StateObject private var viewModel: ArticleViewModel
    
    @Binding var presentingDestination: Bool
    @Binding var destinationURL: String
    
    init(article: Article, presentingDestination: Binding<Bool>, destinationURL: Binding<String>) {
        self._viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
        self._presentingDestination = presentingDestination
        self._destinationURL = destinationURL
    }
    
    var body: some View {
        ZStack {
            Color.adaptiveBackground
            
            VStack(spacing: 10) {
                viewModel.thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25)
                    )
                
                VStack(spacing: 15) {
                    Text(viewModel.getArticleTitle())
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.adaptiveText)
                    
                    ArticleMetadataView(articleMetadata: ArticleMetadata(views: 3, timeToRead: 5, date: "2024-11-1"))
                    
                    ArticleAuxiliaryDataBar(articleAuxiliaryData: ArticleAuxiliaryData(loved: false, countOfLoved: 0, shared: 0, comments: []))
                }
            }
        }
        .onTapGesture {
            presentingDestination = true
            destinationURL = viewModel.getArticleURL()
        }
    }
}

#Preview {
    BeatitudoMediaView()
}
