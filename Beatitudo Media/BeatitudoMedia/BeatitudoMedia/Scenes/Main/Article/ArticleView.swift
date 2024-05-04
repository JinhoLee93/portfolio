//
//  ArticleView.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/2/24.
//

import SwiftUI

struct ArticleView: View {
    @StateObject private var viewModel: ArticleViewModel
    
    init(article: Article) {
        _viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
    }
    
    var body: some View {
        ZStack {
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
    }
}

#Preview {
    BeatitudoMediaView()
}
