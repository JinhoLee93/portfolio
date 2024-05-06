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
            
            VStack(alignment: .leading, spacing: 5) {
                ArticleMetadataView(articleMetadata: ArticleMetadata(views: 3, timeToRead: 5, date: "2024-11-1"))
                
                HStack(alignment: .center, spacing: 10) {
                    viewModel.thumbnail?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 100)
                    
                    Text(viewModel.getArticleTitle())
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.adaptiveText)
                }
                    
                ArticleAuxiliaryDataBar(articleAuxiliaryData: ArticleAuxiliaryData(loved: false, countOfLoved: 0, shared: 0, comments: []), articleURL: viewModel.getArticleURL())
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
